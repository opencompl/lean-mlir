module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.and %arg0, %c_37_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.select %2, %arg0, %c35_i64 : i1, i64
    %4 = llvm.select %2, %3, %c21_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %c2_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.xor %1, %arg2 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.ashr %c_19_i64, %1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sle" %arg0, %c22_i64 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "uge" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %c_32_i64 = arith.constant -32 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %c_32_i64, %c_17_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.select %false, %1, %c_15_i64 : i1, i64
    %3 = llvm.select %arg0, %c48_i64, %c_27_i64 : i1, i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "uge" %c14_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c_12_i64, %arg0 : i64
    %1 = llvm.and %0, %c15_i64 : i64
    %2 = llvm.urem %c_22_i64, %c41_i64 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.udiv %c_6_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %c_6_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %c42_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %arg0, %c_19_i64 : i64
    %1 = llvm.icmp "sge" %c_33_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %arg1, %c23_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.xor %arg1, %c_16_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %0, %arg2 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %c_38_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg1, %arg2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.icmp "sge" %c_30_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %3, %c_23_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "slt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %true, %arg0, %c33_i64 : i1, i64
    %1 = llvm.icmp "ne" %arg1, %0 : i64
    %2 = llvm.select %1, %arg2, %c_6_i64 : i1, i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.select %false, %c_43_i64, %arg1 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.urem %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c23_i64 = arith.constant 23 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %c48_i64, %0 : i1, i64
    %2 = llvm.select %arg0, %c23_i64, %c_47_i64 : i1, i64
    %3 = llvm.urem %2, %c_19_i64 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %c32_i64, %0 : i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %arg0, %c47_i64 : i64
    %1 = llvm.or %c_11_i64, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.lshr %c_49_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg2 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.xor %c40_i64, %c5_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.or %arg2, %c_46_i64 : i64
    %3 = llvm.select %false, %1, %2 : i1, i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %c6_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c44_i64 = arith.constant 44 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %arg1, %c10_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.lshr %2, %c22_i64 : i64
    %4 = llvm.icmp "ult" %c44_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.or %c_18_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %c_35_i64, %0 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c_33_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %c11_i64, %arg1 : i64
    %1 = llvm.lshr %arg2, %c_31_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg0, %c_31_i64 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %c40_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_25_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg2, %c_48_i64 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "eq" %c_24_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c3_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.udiv %arg1, %c_5_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.udiv %3, %c_38_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %c_16_i64, %c_49_i64 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.udiv %c11_i64, %c46_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %c29_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.srem %c_3_i64, %c29_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %arg0, %c12_i64 : i64
    %1 = llvm.udiv %c30_i64, %c23_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.and %c_23_i64, %2 : i64
    %4 = llvm.icmp "eq" %c_45_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c_32_i64 = arith.constant -32 : i64
    %false = arith.constant false
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.select %false, %c10_i64, %arg0 : i1, i64
    %1 = llvm.lshr %c43_i64, %arg0 : i64
    %2 = llvm.and %c_32_i64, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %c_45_i64, %0 : i64
    %2 = llvm.urem %c19_i64, %1 : i64
    %3 = llvm.srem %0, %0 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c28_i64 = arith.constant 28 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ne" %c47_i64, %arg0 : i64
    %1 = llvm.srem %c12_i64, %arg1 : i64
    %2 = llvm.select %0, %c28_i64, %1 : i1, i64
    %3 = llvm.srem %arg0, %arg2 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %arg0, %c_17_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %arg2, %0 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c_45_i64, %0 : i64
    %2 = llvm.srem %arg0, %arg1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.select %1, %c_6_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %c_19_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.lshr %1, %c22_i64 : i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "eq" %arg0, %c38_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "eq" %arg1, %c19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.urem %1, %c13_i64 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %arg0, %c_26_i64 : i64
    %1 = llvm.icmp "ult" %c21_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %2, %c_15_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.urem %c32_i64, %arg0 : i64
    %1 = llvm.or %0, %c_7_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ult" %c_47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sge" %arg0, %c47_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.select %0, %c38_i64, %1 : i1, i64
    %3 = llvm.lshr %2, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %c_4_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %c47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c_23_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %c33_i64 : i64
    %2 = llvm.urem %1, %c_13_i64 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %c_28_i64 : i64
    %1 = llvm.icmp "uge" %c_20_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c_8_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg0, %0, %0 : i1, i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sle" %arg0, %c31_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c_29_i64, %1 : i64
    %3 = llvm.udiv %arg0, %arg0 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c_15_i64, %0 : i64
    %2 = llvm.lshr %c4_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.ashr %c_49_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c38_i64, %c_42_i64 : i1, i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ne" %0, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sdiv %arg0, %c11_i64 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c9_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %0, %c_30_i64 : i1, i64
    %2 = llvm.select %false, %arg2, %c_40_i64 : i1, i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "slt" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.srem %arg1, %c_40_i64 : i64
    %1 = llvm.sdiv %0, %c_33_i64 : i64
    %2 = llvm.udiv %arg0, %c_11_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %c4_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "sgt" %c_38_i64, %c_46_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %c_32_i64, %1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %c_8_i64, %arg1 : i64
    %2 = llvm.icmp "eq" %c32_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.sdiv %c_43_i64, %c_9_i64 : i64
    %1 = llvm.icmp "ugt" %arg2, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c_14_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %3, %c_9_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %c50_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.lshr %arg2, %arg1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.select %1, %3, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.srem %c43_i64, %c_10_i64 : i64
    %1 = llvm.ashr %0, %c_38_i64 : i64
    %2 = llvm.xor %arg0, %c_10_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.srem %arg0, %c5_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %arg1, %arg0, %0 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c_26_i64, %arg0 : i1, i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.xor %c_45_i64, %arg2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "ule" %arg1, %c6_i64 : i64
    %1 = llvm.select %0, %arg0, %arg2 : i1, i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %c_7_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.ashr %c_6_i64, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %c_20_i64, %arg0 : i64
    %1 = llvm.or %c19_i64, %0 : i64
    %2 = llvm.icmp "sle" %c32_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %false, %c_45_i64, %arg1 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.urem %arg2, %1 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.urem %2, %c_4_i64 : i64
    %4 = llvm.icmp "sle" %3, %c_10_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg1, %c36_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %3, %c_36_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg0 : i1, i64
    %2 = llvm.or %c_29_i64, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "uge" %3, %c42_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.urem %arg1, %c14_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.ashr %3, %c_14_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %c_27_i64, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.udiv %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.srem %c_41_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %c_18_i64, %2 : i64
    %4 = llvm.icmp "sle" %3, %c_40_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %c2_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %c13_i64 : i64
    %3 = llvm.srem %2, %c13_i64 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %c21_i64, %arg2 : i64
    %2 = llvm.icmp "ne" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %false, %c_37_i64, %c40_i64 : i1, i64
    %1 = llvm.icmp "eq" %0, %c11_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c_49_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.srem %1, %c_4_i64 : i64
    %3 = llvm.icmp "sge" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %c35_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.lshr %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %c_9_i64, %arg1 : i64
    %1 = llvm.icmp "sle" %c34_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.srem %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg2, %arg0 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.sdiv %c_29_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.xor %2, %c_26_i64 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.srem %2, %c_28_i64 : i64
    %4 = llvm.icmp "sge" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c31_i64 = arith.constant 31 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %c14_i64, %arg0 : i64
    %1 = llvm.srem %c_10_i64, %c31_i64 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %3, %c_16_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %0, %0 : i64
    %3 = llvm.lshr %c_9_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %c_8_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %arg2 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %c_15_i64, %arg0 : i64
    %1 = llvm.or %0, %c21_i64 : i64
    %2 = llvm.urem %arg2, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.select %true, %0, %arg1 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %arg2, %c22_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.or %arg1, %c_37_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %0, %arg0 : i64
    %3 = llvm.or %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.and %arg0, %c_41_i64 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.xor %c43_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %c38_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %c_14_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "slt" %c_31_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %c_4_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c21_i64 = arith.constant 21 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %c48_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c21_i64 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %c_49_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "uge" %c34_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %c_49_i64, %1 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "sgt" %c_17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.xor %2, %c_30_i64 : i64
    %4 = llvm.xor %c_6_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %c23_i64 : i1, i64
    %2 = llvm.icmp "ugt" %c_32_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "ult" %c34_i64, %c_40_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %c35_i64 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "ule" %c_44_i64, %c_48_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %c_1_i64, %1 : i64
    %3 = llvm.ashr %1, %arg0 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "eq" %c22_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "uge" %arg0, %c4_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %arg1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %c_43_i64, %2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.or %c_5_i64, %arg0 : i64
    %1 = llvm.urem %c30_i64, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c_44_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.urem %arg2, %c28_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c35_i64, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "slt" %c29_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c24_i64 = arith.constant 24 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.urem %c18_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg1, %c24_i64 : i64
    %2 = llvm.lshr %0, %arg2 : i64
    %3 = llvm.select %1, %c_16_i64, %2 : i1, i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c_45_i64, %c_7_i64 : i64
    %2 = llvm.icmp "ugt" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.ashr %1, %arg2 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %c1_i64, %arg2 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "ule" %2, %c50_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.and %c_29_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %arg0, %c_27_i64 : i64
    %1 = llvm.select %arg2, %arg0, %c_45_i64 : i1, i64
    %2 = llvm.icmp "sge" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c19_i64 = arith.constant 19 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.and %c19_i64, %c_27_i64 : i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c_11_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "ne" %c_17_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.select %arg1, %arg2, %0 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %c_1_i64, %c4_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %c13_i64, %2 : i1, i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c_35_i64, %arg0 : i64
    %1 = llvm.srem %c25_i64, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "slt" %arg1, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.icmp "ult" %c38_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ne" %arg0, %c34_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.trunc %0 : i1 to i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %c_46_i64, %0 : i1, i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %c4_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c24_i64 = arith.constant 24 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.urem %c34_i64, %arg0 : i64
    %1 = llvm.srem %c24_i64, %0 : i64
    %2 = llvm.sdiv %c_9_i64, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ult" %c17_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.srem %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %arg1, %c_4_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c44_i64 = arith.constant 44 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.xor %c44_i64, %c_21_i64 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %c_12_i64, %1 : i64
    %3 = llvm.lshr %c_24_i64, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %c_29_i64, %c31_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sle" %c_6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.select %arg1, %c_14_i64, %2 : i1, i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.zext %arg2 : i1 to i64
    %1 = llvm.urem %0, %c3_i64 : i64
    %2 = llvm.icmp "sle" %arg1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "slt" %c_39_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c_1_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "slt" %c48_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c41_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c23_i64 = arith.constant 23 : i64
    %c29_i64 = arith.constant 29 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.xor %c19_i64, %arg0 : i64
    %1 = llvm.xor %c29_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %c_42_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %c23_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c45_i64 = arith.constant 45 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg1, %arg0, %c40_i64 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.lshr %c45_i64, %c_48_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c_31_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %c30_i64 : i64
    %4 = llvm.icmp "uge" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.and %c_42_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %c_34_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.select %arg2, %c_38_i64, %1 : i1, i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c14_i64 = arith.constant 14 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c14_i64, %c12_i64 : i64
    %1 = llvm.icmp "ult" %0, %c49_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %c_35_i64 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.select %1, %c_26_i64, %c_47_i64 : i1, i64
    %3 = llvm.urem %c39_i64, %2 : i64
    %4 = llvm.icmp "ult" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.and %c_34_i64, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.lshr %c_44_i64, %c_35_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %arg1, %c_16_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %c_44_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.icmp "ule" %c28_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "uge" %arg0, %c27_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c0_i64, %arg0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.and %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.lshr %c_25_i64, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %c_16_i64, %c2_i64 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.select %arg2, %0, %c49_i64 : i1, i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "uge" %c_24_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c_39_i64, %arg2 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c_3_i64 = arith.constant -3 : i64
    %true = arith.constant true
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.select %true, %c_45_i64, %arg0 : i1, i64
    %1 = llvm.srem %0, %c_37_i64 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "ult" %c_3_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c18_i64, %0 : i64
    %2 = llvm.udiv %arg0, %0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.select %2, %3, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.udiv %c_15_i64, %arg0 : i64
    %1 = llvm.sdiv %c_42_i64, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %c14_i64, %arg0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %c16_i64, %arg0 : i64
    %1 = llvm.lshr %arg2, %c24_i64 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "eq" %c_43_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.lshr %c_33_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %arg0, %c16_i64 : i64
    %1 = llvm.sdiv %c42_i64, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c50_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %c_24_i64 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %c50_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %0, %c20_i64 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %c_16_i64, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.lshr %3, %c50_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %0, %c_10_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %2, %0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c35_i64 = arith.constant 35 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %c35_i64, %c38_i64 : i64
    %1 = llvm.sdiv %0, %c_26_i64 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.srem %arg1, %c29_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ule" %c_23_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %c_7_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %c28_i64 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.or %c_9_i64, %arg0 : i64
    %1 = llvm.udiv %c29_i64, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.or %arg0, %c_44_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "ult" %c16_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %c15_i64, %arg0 : i64
    %1 = llvm.select %arg2, %0, %0 : i1, i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %c_7_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "eq" %arg0, %c_27_i64 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "ult" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.and %c_3_i64, %c_14_i64 : i64
    %1 = llvm.or %c17_i64, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c5_i64 = arith.constant 5 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %c12_i64, %arg0 : i64
    %1 = llvm.urem %c5_i64, %c21_i64 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "ule" %0, %c_7_i64 : i64
    %2 = llvm.select %1, %arg2, %c_46_i64 : i1, i64
    %3 = llvm.or %c7_i64, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c_50_i64 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %arg0, %c2_i64 : i64
    %1 = llvm.urem %c43_i64, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c_22_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c_45_i64 : i64
    %3 = llvm.urem %c31_i64, %0 : i64
    %4 = llvm.select %2, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c_17_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c8_i64 = arith.constant 8 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.or %c8_i64, %1 : i64
    %3 = llvm.icmp "eq" %2, %c18_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ne" %arg0, %c_36_i64 : i64
    %1 = llvm.icmp "eq" %c23_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c47_i64 = arith.constant 47 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %arg0, %c35_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.urem %c_42_i64, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "ugt" %c47_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %c_16_i64, %0 : i64
    %2 = llvm.xor %0, %arg0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sdiv %c12_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c_9_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.xor %c_25_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "uge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "sgt" %c_21_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "ult" %2, %c42_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c28_i64 = arith.constant 28 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %c28_i64, %c27_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "uge" %c35_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %1, %c43_i64 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "sle" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.select %true, %c_32_i64, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.select %false, %c49_i64, %1 : i1, i64
    %3 = llvm.udiv %arg1, %arg2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %false, %arg0, %c39_i64 : i1, i64
    %1 = llvm.and %c_5_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %c_38_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c42_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %c_12_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg1, %arg0 : i1, i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.srem %c_26_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c36_i64, %c28_i64 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c27_i64 = arith.constant 27 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "ult" %arg0, %c18_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg1, %c_34_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sle" %c27_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c12_i64, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c16_i64, %0 : i64
    %2 = llvm.sdiv %c_25_i64, %1 : i64
    %3 = llvm.select %arg0, %c_38_i64, %1 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ult" %c50_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg2, %c_16_i64 : i64
    %3 = llvm.urem %2, %c38_i64 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %c29_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sdiv %c_6_i64, %c36_i64 : i64
    %1 = llvm.and %c_49_i64, %0 : i64
    %2 = llvm.srem %c37_i64, %1 : i64
    %3 = llvm.sdiv %arg0, %arg1 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %true = arith.constant true
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ne" %c_16_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c24_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.select %0, %2, %2 : i1, i64
    %4 = llvm.select %true, %arg0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "ule" %c9_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c1_i64 = arith.constant 1 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.udiv %c1_i64, %c24_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c19_i64, %0 : i64
    %2 = llvm.or %c22_i64, %0 : i64
    %3 = llvm.select %1, %0, %2 : i1, i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c_46_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.select %arg0, %c_39_i64, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.icmp "ule" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.xor %c28_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c25_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "sgt" %arg1, %c27_i64 : i64
    %1 = llvm.select %0, %arg1, %c48_i64 : i1, i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.sdiv %c_46_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %arg0, %c_16_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.select %2, %arg2, %arg2 : i1, i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.or %arg0, %c_26_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %c36_i64, %arg0 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %c48_i64 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.select %arg1, %c_35_i64, %c_29_i64 : i1, i64
    %1 = llvm.urem %0, %c2_i64 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c10_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c47_i64 = arith.constant 47 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "uge" %c47_i64, %c18_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %c_27_i64, %arg1 : i64
    %3 = llvm.icmp "ugt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.udiv %2, %c30_i64 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %arg2 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c12_i64 = arith.constant 12 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.or %c_6_i64, %arg0 : i64
    %1 = llvm.xor %0, %c_34_i64 : i64
    %2 = llvm.icmp "sle" %c12_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c_25_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %arg0, %c16_i64 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.lshr %2, %c9_i64 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %c_45_i64, %0 : i64
    %2 = llvm.ashr %1, %c_16_i64 : i64
    %3 = llvm.or %2, %arg1 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %2, %c_46_i64 : i64
    %4 = llvm.icmp "sle" %3, %c48_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c15_i64, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c41_i64 = arith.constant 41 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %c41_i64, %c40_i64 : i64
    %1 = llvm.select %arg0, %c14_i64, %0 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.select %2, %0, %0 : i1, i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sgt" %c47_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.lshr %1, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sge" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "uge" %c_41_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "slt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c32_i64 : i64
    %2 = llvm.ashr %c42_i64, %arg0 : i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %c37_i64, %c_15_i64 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.udiv %arg2, %c6_i64 : i64
    %3 = llvm.ashr %2, %arg2 : i64
    %4 = llvm.select %arg0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.udiv %c13_i64, %arg1 : i64
    %2 = llvm.icmp "sgt" %1, %c_1_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %3, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.icmp "uge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %c31_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.select %2, %c38_i64, %0 : i1, i64
    %4 = llvm.ashr %c_48_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.icmp "ugt" %c23_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.udiv %c24_i64, %c20_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %c36_i64, %0 : i64
    %2 = llvm.or %arg1, %c_28_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "slt" %c47_i64, %arg0 : i64
    %1 = llvm.sdiv %c_21_i64, %c20_i64 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.select %0, %3, %1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "sgt" %c_23_i64, %c_17_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.icmp "ne" %2, %c_39_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.lshr %c_8_i64, %c25_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.select %3, %c_47_i64, %2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c_35_i64, %0 : i64
    %2 = llvm.select %1, %c_46_i64, %arg1 : i1, i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %c8_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.and %arg1, %c_36_i64 : i64
    %4 = llvm.select %2, %3, %c26_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %1, %c17_i64 : i64
    %3 = llvm.select %false, %2, %1 : i1, i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %c_5_i64, %c_4_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c28_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ugt" %arg0, %c40_i64 : i64
    %1 = llvm.urem %c_26_i64, %c9_i64 : i64
    %2 = llvm.xor %c_8_i64, %1 : i64
    %3 = llvm.sext %0 : i1 to i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.ashr %c_44_i64, %c27_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %c41_i64, %arg1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_3_i64 = arith.constant -3 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %c11_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.xor %c40_i64, %c_32_i64 : i64
    %3 = llvm.select %arg2, %c_3_i64, %2 : i1, i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_30_i64 = arith.constant -30 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %arg0, %c_36_i64 : i64
    %1 = llvm.lshr %c_30_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %c42_i64 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c40_i64 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.icmp "slt" %c12_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.srem %c_12_i64, %arg0 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %c11_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_41_i64 = arith.constant -41 : i64
    %false = arith.constant false
    %c_17_i64 = arith.constant -17 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %c_17_i64, %c24_i64 : i64
    %1 = llvm.icmp "sle" %0, %c_43_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %false, %2, %arg0 : i1, i64
    %4 = llvm.icmp "sgt" %c_41_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.select %false, %arg1, %arg1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c2_i64, %arg0 : i1, i64
    %2 = llvm.icmp "sgt" %c_27_i64, %c_42_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c_40_i64 : i64
    %2 = llvm.xor %c_31_i64, %1 : i64
    %3 = llvm.icmp "uge" %c22_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "eq" %arg0, %c41_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.or %1, %1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %c_3_i64 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c20_i64, %c13_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %arg0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %arg0, %c10_i64 : i64
    %1 = llvm.sdiv %c_23_i64, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c23_i64 = arith.constant 23 : i64
    %c49_i64 = arith.constant 49 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg0, %c49_i64, %c39_i64 : i1, i64
    %1 = llvm.ashr %c23_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %2, %c6_i64 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %c_9_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %c44_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_26_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %2, %c36_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "sle" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %arg1, %c_37_i64 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.srem %2, %c32_i64 : i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c13_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %c17_i64 : i64
    %2 = llvm.icmp "ne" %1, %c22_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %arg0, %c50_i64, %c41_i64 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sle" %c40_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %arg2 : i64
    %3 = llvm.select %2, %c_30_i64, %1 : i1, i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.select %false, %c_1_i64, %arg0 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %c39_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ugt" %c10_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %c_46_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.select %arg1, %2, %1 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c32_i64 = arith.constant 32 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c32_i64, %c30_i64 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.select %1, %0, %c_42_i64 : i1, i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg1, %arg2 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c39_i64 : i64
    %2 = llvm.icmp "ule" %c_38_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %true = arith.constant true
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %c_8_i64 : i64
    %1 = llvm.udiv %0, %c_11_i64 : i64
    %2 = llvm.select %true, %1, %0 : i1, i64
    %3 = llvm.lshr %0, %0 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %c_3_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg0 : i1, i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.urem %c33_i64, %2 : i64
    %4 = llvm.icmp "ugt" %c5_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.srem %arg0, %c16_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %c4_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %c21_i64, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.lshr %2, %c_9_i64 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.udiv %0, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %0, %c_16_i64 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg1, %c43_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c34_i64 = arith.constant 34 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %c34_i64, %0 : i64
    %2 = llvm.or %1, %c29_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %c_46_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %c_12_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c_40_i64 = arith.constant -40 : i64
    %true = arith.constant true
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %arg0, %c_40_i64 : i64
    %3 = llvm.lshr %2, %c_15_i64 : i64
    %4 = llvm.select %true, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.sdiv %c_22_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg0, %c_8_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ult" %2, %c32_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg1, %arg0, %2 : i1, i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.or %c_31_i64, %arg0 : i64
    %1 = llvm.or %0, %c1_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "uge" %c44_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %c37_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "uge" %c_38_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "eq" %c13_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "uge" %c40_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c_38_i64, %1 : i64
    %3 = llvm.select %2, %1, %1 : i1, i64
    %4 = llvm.icmp "uge" %3, %c35_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c_27_i64 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.or %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.urem %arg2, %0 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c_49_i64, %0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.lshr %arg1, %c16_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg0, %c_41_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.ashr %c25_i64, %1 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.srem %c_35_i64, %arg0 : i64
    %1 = llvm.srem %0, %c40_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ule" %c_8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.udiv %2, %c_2_i64 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.and %c_23_i64, %c_32_i64 : i64
    %1 = llvm.sdiv %0, %c_10_i64 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "ult" %3, %c_3_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.udiv %arg1, %c_36_i64 : i64
    %1 = llvm.udiv %c_25_i64, %arg2 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.icmp "sge" %1, %c_27_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_3_i64 = arith.constant -3 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %c34_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.select %2, %c_3_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %c_48_i64, %c33_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %arg1, %c8_i64 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.or %c_1_i64, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %c_40_i64, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "ule" %c_14_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %arg0, %c5_i64 : i64
    %1 = llvm.sdiv %c_1_i64, %arg1 : i64
    %2 = llvm.xor %c_30_i64, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %c_18_i64 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %false = arith.constant false
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.select %false, %c_9_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %c4_i64 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.urem %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c9_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.select %true, %arg0, %c15_i64 : i1, i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.udiv %1, %arg1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %c_22_i64, %arg1 : i64
    %2 = llvm.sdiv %c_42_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "sge" %c9_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.xor %arg1, %arg1 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sdiv %c3_i64, %c49_i64 : i64
    %1 = llvm.udiv %c49_i64, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %arg1, %arg2 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.urem %c_39_i64, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.icmp "sle" %0, %c_1_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "sle" %arg0, %c7_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %c_38_i64, %1 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg2, %c_5_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %c24_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %arg1 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c_40_i64, %0 : i64
    %2 = llvm.icmp "ule" %c35_i64, %1 : i64
    %3 = llvm.udiv %arg0, %1 : i64
    %4 = llvm.select %2, %3, %c7_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c16_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.sdiv %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %c_11_i64, %arg0 : i64
    %1 = llvm.udiv %arg2, %0 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %c_40_i64 = arith.constant -40 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %c_40_i64, %c14_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.and %c_12_i64, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %0, %c_22_i64 : i64
    %2 = llvm.icmp "ugt" %c4_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %c_27_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %c24_i64, %c_15_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.sdiv %1, %1 : i64
    %4 = llvm.select %2, %3, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %c16_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c_41_i64 = arith.constant -41 : i64
    %c_19_i64 = arith.constant -19 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.udiv %arg0, %c7_i64 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.srem %c_19_i64, %c_41_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.lshr %3, %c_2_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ule" %c48_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %c11_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %c13_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %c_2_i64, %c_40_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg1, %c_36_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "sle" %arg0, %c12_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c6_i64, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "eq" %arg0, %c34_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c_38_i64 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %0, %c23_i64 : i1, i64
    %2 = llvm.xor %arg1, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c45_i64 = arith.constant 45 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "ugt" %arg0, %c1_i64 : i64
    %1 = llvm.select %0, %arg0, %c_32_i64 : i1, i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %c45_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %c_30_i64, %2 : i64
    %4 = llvm.or %c49_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.ashr %c46_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %c50_i64 : i64
    %2 = llvm.select %1, %arg2, %0 : i1, i64
    %3 = llvm.select %arg1, %c_50_i64, %2 : i1, i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.xor %c_50_i64, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.srem %arg1, %c12_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.select %arg2, %0, %1 : i1, i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.or %arg0, %c_24_i64 : i64
    %1 = llvm.select %false, %c_13_i64, %arg0 : i1, i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %1, %c4_i64 : i64
    %3 = llvm.lshr %2, %c19_i64 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg2 : i1, i64
    %1 = llvm.srem %0, %c37_i64 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %arg0, %c20_i64 : i64
    %1 = llvm.srem %arg1, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c_39_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.ashr %c_32_i64, %c47_i64 : i64
    %1 = llvm.icmp "sle" %c2_i64, %arg0 : i64
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ule" %c10_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c_26_i64, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "uge" %c_34_i64, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %c_28_i64, %c5_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.and %arg0, %c47_i64 : i64
    %1 = llvm.or %c_47_i64, %0 : i64
    %2 = llvm.udiv %arg0, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.sdiv %c20_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.sdiv %0, %arg0 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.lshr %arg2, %c_11_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.xor %arg0, %c_42_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.or %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %c43_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ugt" %c13_i64, %c_44_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %c_43_i64 = arith.constant -43 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.and %c_43_i64, %c_26_i64 : i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.xor %arg1, %arg2 : i64
    %4 = llvm.select %2, %3, %c20_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.select %arg1, %1, %c42_i64 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sgt" %c46_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %arg0, %c_24_i64 : i64
    %1 = llvm.icmp "uge" %c_1_i64, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ult" %c49_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "slt" %c_7_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "eq" %c19_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "slt" %c24_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %arg1, %arg0 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %c_36_i64, %arg0 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_15_i64, %c38_i64 : i1, i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %arg2 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %c_28_i64 : i64
    %4 = llvm.or %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %c_39_i64, %0 : i64
    %2 = llvm.urem %1, %c_18_i64 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sge" %c_15_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c_5_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c40_i64 = arith.constant 40 : i64
    %c13_i64 = arith.constant 13 : i64
    %c14_i64 = arith.constant 14 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.xor %arg0, %c3_i64 : i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.icmp "eq" %c13_i64, %0 : i64
    %3 = llvm.select %2, %c40_i64, %c_30_i64 : i1, i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c_43_i64 : i64
    %2 = llvm.icmp "ugt" %c41_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ne" %c26_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.lshr %0, %c16_i64 : i64
    %2 = llvm.ashr %1, %c_38_i64 : i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %c_50_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg2, %c20_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.select %arg0, %arg1, %1 : i1, i64
    %3 = llvm.sdiv %0, %arg1 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.select %false, %arg0, %arg0 : i1, i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.or %c_30_i64, %arg0 : i64
    %1 = llvm.srem %c_31_i64, %0 : i64
    %2 = llvm.udiv %arg1, %c_24_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.ashr %c_29_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c45_i64, %c_10_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.select %1, %arg2, %arg0 : i1, i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ule" %3, %c17_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.select %2, %arg0, %c_47_i64 : i1, i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c37_i64 = arith.constant 37 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %c44_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.and %c37_i64, %c28_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %c10_i64, %arg1 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.udiv %3, %c_30_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %c_36_i64, %c47_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %c_40_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %arg0, %c_33_i64 : i64
    %1 = llvm.sdiv %c0_i64, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.and %arg2, %c_23_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sgt" %2, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.urem %c_4_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.or %1, %c_31_i64 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sge" %arg0, %c19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %true, %arg0, %c33_i64 : i1, i64
    %3 = llvm.select %0, %c23_i64, %2 : i1, i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg1, %c20_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c21_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %c30_i64, %0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %c_9_i64 : i64
    %2 = llvm.srem %arg2, %c48_i64 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c27_i64 = arith.constant 27 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.ashr %c27_i64, %c0_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.and %c_35_i64, %c37_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %true, %arg1, %0 : i1, i64
    %2 = llvm.ashr %c17_i64, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %c14_i64, %c8_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %c20_i64 = arith.constant 20 : i64
    %false = arith.constant false
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %false, %c16_i64, %arg0 : i1, i64
    %1 = llvm.or %c_38_i64, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.xor %c20_i64, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.and %arg0, %c_13_i64 : i64
    %1 = llvm.sdiv %c1_i64, %arg1 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.select %true, %0, %2 : i1, i64
    %4 = llvm.urem %c_22_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ne" %c27_i64, %c_26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %c_15_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.urem %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg2 : i64
    %2 = llvm.or %1, %c_38_i64 : i64
    %3 = llvm.lshr %arg1, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %c40_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.xor %c0_i64, %arg0 : i64
    %1 = llvm.or %arg0, %c22_i64 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "uge" %c_9_i64, %c24_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %c_48_i64 : i64
    %3 = llvm.select %0, %2, %arg0 : i1, i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %c_30_i64, %c42_i64 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ne" %c_19_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %c_32_i64 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    %3 = llvm.select %2, %arg2, %c_43_i64 : i1, i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c14_i64 = arith.constant 14 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c_20_i64, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.ashr %arg2, %c14_i64 : i64
    %3 = llvm.srem %2, %c_43_i64 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.srem %c9_i64, %c35_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.lshr %c_19_i64, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.urem %arg2, %c23_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_43_i64 = arith.constant -43 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ugt" %c_34_i64, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.icmp "ult" %c_43_i64, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %c19_i64, %0 : i64
    %2 = llvm.select %true, %c_44_i64, %arg1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.udiv %1, %c19_i64 : i64
    %3 = llvm.urem %1, %arg1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %c29_i64 : i64
    %2 = llvm.xor %1, %c_6_i64 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c40_i64 = arith.constant 40 : i64
    %c31_i64 = arith.constant 31 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c31_i64, %c_32_i64 : i64
    %1 = llvm.lshr %c40_i64, %c_6_i64 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %arg0, %c39_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.and %arg1, %arg0 : i64
    %4 = llvm.select %2, %arg1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %arg1, %arg1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %c_29_i64 : i64
    %2 = llvm.trunc %true : i1 to i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.select %0, %1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %1, %c_24_i64 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.srem %c5_i64, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %arg1, %0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg2, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.lshr %arg1, %c22_i64 : i64
    %1 = llvm.sdiv %arg1, %c_37_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.icmp "ult" %arg0, %c_44_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.or %2, %0 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %c_43_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %arg0, %c_36_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %1, %c11_i64 : i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "slt" %c49_i64, %c_31_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sdiv %arg0, %c45_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %c0_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %arg0, %c1_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.urem %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.select %arg0, %arg2, %arg2 : i1, i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c48_i64 : i64
    %2 = llvm.urem %c23_i64, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %c10_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.select %arg0, %0, %2 : i1, i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %arg0, %c25_i64 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c_47_i64, %c_4_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.select %1, %c_43_i64, %arg2 : i1, i64
    %3 = llvm.sdiv %2, %c_14_i64 : i64
    %4 = llvm.select %1, %3, %c42_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %true = arith.constant true
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %true, %1, %arg0 : i1, i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "sge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %c_21_i64, %c_47_i64 : i64
    %1 = llvm.select %arg0, %0, %c_27_i64 : i1, i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %3, %c31_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %3, %1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "uge" %arg0, %c30_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sle" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.or %c_18_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %c_41_i64, %arg0 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.sdiv %arg1, %c14_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.lshr %arg0, %c_43_i64 : i64
    %1 = llvm.srem %0, %c_29_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %c_36_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sgt" %c_24_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c33_i64, %1 : i64
    %3 = llvm.udiv %1, %arg0 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %c42_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.xor %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg0, %c_11_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %c38_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %arg1, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.udiv %1, %1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.or %0, %c36_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.lshr %c_49_i64, %2 : i64
    %4 = llvm.icmp "ule" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.xor %arg2, %c_40_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.or %1, %c_38_i64 : i64
    %3 = llvm.srem %2, %c4_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.urem %arg2, %0 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "ugt" %c_14_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c_8_i64, %1 : i64
    %3 = llvm.sdiv %c_18_i64, %2 : i64
    %4 = llvm.udiv %c35_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c17_i64 = arith.constant 17 : i64
    %c_12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sdiv %c_12_i64, %c17_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.ashr %c_42_i64, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %c_23_i64, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %c_17_i64, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "eq" %c14_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.sdiv %arg0, %c30_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.select %2, %0, %1 : i1, i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %true, %arg1, %arg1 : i1, i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "ult" %arg1, %1 : i64
    %3 = llvm.select %2, %c46_i64, %c_14_i64 : i1, i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "ne" %c14_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg2, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c33_i64 = arith.constant 33 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %c25_i64, %1 : i64
    %3 = llvm.udiv %c33_i64, %c_37_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.lshr %c36_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.sdiv %0, %c31_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %c_32_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.or %c_17_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.or %c_9_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.icmp "sge" %3, %c_18_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.udiv %1, %arg0 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.srem %c30_i64, %c27_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.lshr %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "sle" %c_4_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.lshr %2, %arg0 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %c_23_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c41_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %c2_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c_26_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.lshr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %c48_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "ugt" %2, %c30_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c39_i64, %c_15_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %c2_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "ule" %c_31_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.sdiv %0, %arg2 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c_28_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.icmp "sgt" %c37_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.or %c_3_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %c1_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ule" %c_6_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %arg2, %c0_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %c_28_i64, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %c9_i64 : i64
    %3 = llvm.srem %2, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.icmp "uge" %c41_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %arg1, %c0_i64 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "slt" %arg0, %c18_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.ashr %arg0, %c6_i64 : i64
    %1 = llvm.icmp "uge" %c48_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "eq" %c1_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.xor %arg1, %0 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.urem %3, %c_23_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c_24_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c5_i64 = arith.constant 5 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ne" %c5_i64, %c46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %c_50_i64, %arg0 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c47_i64, %0 : i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.srem %c_33_i64, %2 : i64
    %4 = llvm.select %1, %3, %arg2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c26_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %arg0, %c_47_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.udiv %c14_i64, %c10_i64 : i64
    %1 = llvm.select %arg2, %arg1, %arg1 : i1, i64
    %2 = llvm.select %arg2, %0, %1 : i1, i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c28_i64, %c35_i64 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.xor %c47_i64, %2 : i64
    %4 = llvm.icmp "sgt" %c_32_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.urem %c24_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.trunc %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c43_i64 = arith.constant 43 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %c_9_i64, %c_13_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %c43_i64, %1 : i64
    %3 = llvm.icmp "uge" %2, %c34_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.icmp "ne" %2, %c37_i64 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %arg0, %c_26_i64 : i64
    %1 = llvm.icmp "ne" %c_40_i64, %arg1 : i64
    %2 = llvm.lshr %arg0, %0 : i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %c_37_i64, %0 : i64
    %2 = llvm.srem %arg2, %0 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.select %arg1, %c_48_i64, %arg2 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.and %c_13_i64, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %false = arith.constant false
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.udiv %arg0, %c_7_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.udiv %1, %c_16_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "sge" %c15_i64, %c_32_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "eq" %c_38_i64, %arg0 : i64
    %1 = llvm.select %0, %c15_i64, %arg0 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.udiv %2, %c_15_i64 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c_18_i64, %c_36_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.select %arg1, %arg0, %c_3_i64 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %c34_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %c40_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "slt" %c_8_i64, %arg0 : i64
    %1 = llvm.select %0, %c43_i64, %arg0 : i1, i64
    %2 = llvm.udiv %c4_i64, %1 : i64
    %3 = llvm.or %arg0, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c_6_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %arg1, %arg2 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %c_43_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "ne" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %c_17_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c28_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "slt" %c_18_i64, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c_43_i64, %1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.udiv %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c14_i64 = arith.constant 14 : i64
    %c31_i64 = arith.constant 31 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %c31_i64, %c14_i64 : i64
    %2 = llvm.or %arg0, %c1_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "sle" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c1_i64 = arith.constant 1 : i64
    %false = arith.constant false
    %c_27_i64 = arith.constant -27 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %false, %c_27_i64, %c14_i64 : i1, i64
    %1 = llvm.srem %c1_i64, %0 : i64
    %2 = llvm.srem %c_46_i64, %arg0 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %c_18_i64, %c_8_i64 : i64
    %1 = llvm.srem %arg0, %c_15_i64 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.select %0, %arg2, %c30_i64 : i1, i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %arg0, %c_32_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %1, %c2_i64 : i64
    %3 = llvm.lshr %c30_i64, %2 : i64
    %4 = llvm.or %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "sge" %c_38_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.select %0, %2, %arg2 : i1, i64
    %4 = llvm.lshr %c36_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.or %c16_i64, %arg1 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.icmp "eq" %0, %c32_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.icmp "ult" %c28_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %c_41_i64, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %c_18_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %c48_i64, %0 : i64
    %2 = llvm.icmp "eq" %c_2_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c21_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.sdiv %c30_i64, %1 : i64
    %3 = llvm.srem %2, %c11_i64 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.lshr %arg1, %arg2 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %c_50_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.icmp "sgt" %arg0, %c23_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %c19_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.select %0, %arg0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %arg0, %c_7_i64, %0 : i1, i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c37_i64 = arith.constant 37 : i64
    %c43_i64 = arith.constant 43 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %c1_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %c43_i64 : i64
    %2 = llvm.srem %c31_i64, %arg1 : i64
    %3 = llvm.and %c37_i64, %2 : i64
    %4 = llvm.select %1, %3, %2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c5_i64 = arith.constant 5 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.select %arg0, %c22_i64, %arg1 : i1, i64
    %1 = llvm.lshr %c5_i64, %arg2 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %3, %c38_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.udiv %c6_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %arg2, %2 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %c40_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "ult" %c41_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_14_i64 = arith.constant -14 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg2, %arg2 : i1, i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.select %arg0, %c_14_i64, %c25_i64 : i1, i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %arg2, %0 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.urem %0, %c33_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.and %c13_i64, %arg1 : i64
    %2 = llvm.icmp "ult" %arg2, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c44_i64 = arith.constant 44 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sdiv %c44_i64, %c20_i64 : i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.udiv %c_44_i64, %c_17_i64 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.and %arg2, %arg0 : i64
    %3 = llvm.select %false, %0, %2 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %arg2, %arg1 : i64
    %2 = llvm.and %1, %0 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c30_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %true = arith.constant true
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.select %true, %arg0, %c_40_i64 : i1, i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "ule" %3, %c_20_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.and %c40_i64, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "uge" %c44_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ugt" %c8_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c_11_i64, %1 : i64
    %3 = llvm.select %arg1, %arg0, %2 : i1, i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "slt" %arg0, %c_30_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.urem %arg1, %arg0 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.xor %c45_i64, %0 : i64
    %2 = llvm.select %arg0, %1, %1 : i1, i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %arg0, %c_35_i64 : i64
    %1 = llvm.icmp "ugt" %0, %c_13_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "slt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.udiv %c44_i64, %arg0 : i64
    %1 = llvm.or %c_36_i64, %0 : i64
    %2 = llvm.urem %arg0, %arg1 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %1, %c_26_i64 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.lshr %arg0, %c40_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.sdiv %c_3_i64, %arg2 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg1, %c30_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.lshr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %false, %0, %arg1 : i1, i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.icmp "ne" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %0, %c49_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %c_40_i64, %0 : i64
    %2 = llvm.icmp "eq" %c12_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.sdiv %arg0, %c36_i64 : i64
    %1 = llvm.srem %arg0, %c_27_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.lshr %1, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c_37_i64 : i1, i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.srem %2, %arg0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sdiv %arg1, %c11_i64 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.lshr %c_36_i64, %c_2_i64 : i64
    %1 = llvm.icmp "slt" %arg0, %c_23_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %2, %0 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %arg0, %c_25_i64 : i64
    %1 = llvm.icmp "slt" %c_17_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %c_6_i64, %0 : i64
    %2 = llvm.or %arg2, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ult" %c_2_i64, %c_33_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %c48_i64, %c43_i64 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "sle" %arg0, %c_11_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %c_2_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.icmp "slt" %0, %c15_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sle" %c_14_i64, %c_43_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c9_i64 : i1, i64
    %3 = llvm.sdiv %arg1, %arg2 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %c37_i64 : i64
    %4 = llvm.sdiv %3, %c41_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.sdiv %c_35_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.and %c_36_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %c_35_i64, %c12_i64 : i64
    %1 = llvm.lshr %0, %c37_i64 : i64
    %2 = llvm.or %arg0, %arg1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "eq" %3, %c_9_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %c_28_i64, %c20_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.select %true, %c13_i64, %arg1 : i1, i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.or %c43_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %arg0, %0 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.urem %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.or %arg0, %c_2_i64 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.udiv %c1_i64, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sdiv %c9_i64, %c_44_i64 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    %3 = llvm.or %2, %2 : i64
    %4 = llvm.icmp "ne" %c_37_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %0, %c_36_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.xor %c46_i64, %arg0 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %arg0, %c_31_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg0, %c16_i64 : i64
    %1 = llvm.ashr %c12_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.and %1, %arg1 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "eq" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %1, %c_31_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_10_i64 : i64
    %1 = llvm.select %0, %arg0, %c31_i64 : i1, i64
    %2 = llvm.icmp "ne" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ult" %1, %c35_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.lshr %arg0, %c28_i64 : i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.or %arg1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ne" %c_41_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %c_11_i64, %1 : i64
    %3 = llvm.sdiv %c36_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c15_i64, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %c_23_i64, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "sle" %c28_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %c6_i64, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.icmp "ult" %c38_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %c_9_i64 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "ne" %arg0, %c_9_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.srem %2, %c_14_i64 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %c50_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.srem %0, %c_12_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %arg0, %c21_i64 : i64
    %1 = llvm.icmp "slt" %c_23_i64, %c_26_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %c_38_i64, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "sge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.sdiv %arg0, %c8_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.xor %c_5_i64, %arg0 : i64
    %1 = llvm.urem %c_5_i64, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %c21_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ult" %0, %c_21_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %c_46_i64, %2 : i64
    %4 = llvm.icmp "uge" %c33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %c_5_i64, %c_36_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.icmp "ugt" %c_30_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sext %0 : i1 to i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.select %arg0, %c_18_i64, %c20_i64 : i1, i64
    %1 = llvm.icmp "sge" %c8_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %c_29_i64 : i1, i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ne" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "sle" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.or %arg0, %c_44_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.and %2, %0 : i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.or %c18_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %c_43_i64, %c_22_i64 : i64
    %1 = llvm.urem %c_48_i64, %arg0 : i64
    %2 = llvm.srem %1, %c_50_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %c32_i64, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    %3 = llvm.srem %0, %c_7_i64 : i64
    %4 = llvm.select %2, %0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.select %1, %c40_i64, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c36_i64 = arith.constant 36 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.select %arg0, %c_16_i64, %c_47_i64 : i1, i64
    %1 = llvm.udiv %0, %c_9_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %c36_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.lshr %c7_i64, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.icmp "ult" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %c38_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c_24_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.ashr %2, %c_34_i64 : i64
    %4 = llvm.icmp "slt" %c_9_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %c12_i64 = arith.constant 12 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %c12_i64, %c_20_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "eq" %c3_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.lshr %c5_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.or %1, %c_36_i64 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.xor %3, %c_10_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %1 = llvm.ashr %c39_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %c39_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sgt" %c_40_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c_50_i64, %arg1 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %arg0, %c49_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ult" %3, %c41_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.or %c_32_i64, %arg0 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sle" %c_15_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.xor %0, %arg0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg1, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %arg0, %arg1, %2 : i1, i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.or %arg1, %c43_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "uge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.ashr %c28_i64, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.ashr %arg2, %c13_i64 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.ashr %c33_i64, %arg0 : i64
    %1 = llvm.srem %c_4_i64, %arg0 : i64
    %2 = llvm.srem %arg0, %c_35_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ne" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ne" %c_2_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.urem %0, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.icmp "sge" %c_42_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.select %false, %arg0, %c_24_i64 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %c_28_i64, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %arg0, %c_37_i64 : i64
    %1 = llvm.ashr %c_24_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c_4_i64, %arg1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %c35_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.xor %2, %c19_i64 : i64
    %4 = llvm.icmp "uge" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "sge" %c33_i64, %arg0 : i64
    %1 = llvm.select %0, %c12_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.icmp "eq" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c7_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %c_29_i64, %0 : i1, i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.or %arg2, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.lshr %c_30_i64, %2 : i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "sge" %c_47_i64, %c27_i64 : i64
    %1 = llvm.icmp "ule" %arg1, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "ugt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "sgt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.select %false, %arg1, %c_22_i64 : i1, i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.and %2, %arg2 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %arg0, %c_29_i64 : i64
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %c14_i64, %0 : i64
    %2 = llvm.or %arg0, %0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %arg1, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "slt" %c_25_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c_18_i64, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sgt" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %c47_i64, %0 : i64
    %2 = llvm.or %arg2, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %c23_i64 : i64
    %2 = llvm.sext %arg2 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.udiv %c_32_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c15_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %c12_i64 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c_13_i64, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.ashr %c_36_i64, %c_17_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.lshr %c_37_i64, %2 : i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %arg1, %0 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c45_i64 = arith.constant 45 : i64
    %true = arith.constant true
    %c20_i64 = arith.constant 20 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %c_46_i64, %arg0 : i64
    %1 = llvm.select %true, %c20_i64, %0 : i1, i64
    %2 = llvm.udiv %c_22_i64, %0 : i64
    %3 = llvm.srem %c45_i64, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.sdiv %c_26_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c35_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.ashr %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %c20_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c_23_i64 = arith.constant -23 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "slt" %arg0, %c44_i64 : i64
    %1 = llvm.select %0, %arg0, %c_9_i64 : i1, i64
    %2 = llvm.lshr %c_23_i64, %c_32_i64 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "uge" %c_5_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %3, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %c_20_i64 : i64
    %3 = llvm.udiv %1, %arg0 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.select %arg0, %arg1, %c_11_i64 : i1, i64
    %1 = llvm.icmp "ugt" %c_24_i64, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.and %arg2, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %c_5_i64, %0 : i64
    %2 = llvm.srem %1, %c33_i64 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %c_32_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.and %1, %c_50_i64 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %true, %c46_i64, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    %3 = llvm.udiv %c44_i64, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.urem %c4_i64, %arg1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sdiv %2, %arg1 : i64
    %4 = llvm.or %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg0, %c_16_i64 : i64
    %1 = llvm.ashr %0, %c_35_i64 : i64
    %2 = llvm.udiv %c35_i64, %1 : i64
    %3 = llvm.udiv %c_19_i64, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %false = arith.constant false
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.and %arg1, %c1_i64 : i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "ult" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg2, %c34_i64 : i1, i64
    %2 = llvm.ashr %c11_i64, %1 : i64
    %3 = llvm.select %0, %2, %c34_i64 : i1, i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %arg1, %c_19_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %c34_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %c_39_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.icmp "ne" %3, %c43_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %false = arith.constant false
    %c_39_i64 = arith.constant -39 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.select %false, %c_39_i64, %c_38_i64 : i1, i64
    %1 = llvm.icmp "sgt" %c_9_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %c_16_i64, %0 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.icmp "sle" %2, %c_49_i64 : i64
    %4 = llvm.select %3, %arg1, %2 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %arg0, %c_27_i64 : i1, i64
    %2 = llvm.and %1, %c44_i64 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ne" %c4_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.or %c_7_i64, %arg2 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c13_i64 = arith.constant 13 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c_42_i64, %arg0 : i64
    %1 = llvm.urem %c13_i64, %0 : i64
    %2 = llvm.icmp "ult" %c_27_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %c2_i64, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg2 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.select %arg0, %c_22_i64, %arg1 : i1, i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.or %c25_i64, %arg0 : i64
    %1 = llvm.sdiv %c_35_i64, %0 : i64
    %2 = llvm.xor %0, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c_6_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg0 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %c_26_i64 : i64
    %2 = llvm.icmp "ule" %0, %c_47_i64 : i64
    %3 = llvm.select %2, %0, %0 : i1, i64
    %4 = llvm.select %1, %3, %0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "sgt" %arg0, %c_36_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg1, %c_33_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %c41_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sdiv %c_42_i64, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %c34_i64 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i64
    %4 = llvm.icmp "slt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c45_i64, %arg0 : i1, i64
    %2 = llvm.icmp "sle" %c14_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c13_i64 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.ashr %c_29_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %c_24_i64, %arg0 : i64
    %1 = llvm.xor %c_44_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %c7_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "uge" %c_29_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "uge" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    %3 = llvm.and %0, %arg1 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c0_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg2 : i1 to i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %c50_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %arg0, %c_22_i64 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %c_21_i64, %c7_i64 : i64
    %1 = llvm.icmp "ugt" %arg2, %0 : i64
    %2 = llvm.select %1, %c_39_i64, %0 : i1, i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c_1_i64 = arith.constant -1 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ne" %c_27_i64, %c_24_i64 : i64
    %1 = llvm.select %0, %arg0, %c_1_i64 : i1, i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %false, %2, %arg2 : i1, i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.icmp "ne" %c_49_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c_27_i64, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.srem %c18_i64, %c3_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "sgt" %arg0, %c_43_i64 : i64
    %1 = llvm.icmp "ne" %arg1, %arg2 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %0, %2, %2 : i1, i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %true = arith.constant true
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.select %true, %c_4_i64, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %c11_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %0, %c14_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.icmp "ule" %c_11_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.srem %c13_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %0 : i64
    %3 = llvm.icmp "sgt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "ule" %arg0, %c_29_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %c44_i64, %1 : i64
    %3 = llvm.or %1, %arg1 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c48_i64 = arith.constant 48 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %c13_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c48_i64 : i64
    %2 = llvm.lshr %c13_i64, %1 : i64
    %3 = llvm.udiv %2, %c8_i64 : i64
    %4 = llvm.or %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c50_i64 = arith.constant 50 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %c50_i64, %c_7_i64 : i64
    %1 = llvm.icmp "eq" %c4_i64, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %arg2, %c9_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %true : i1 to i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.and %c40_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.or %c_33_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c19_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %c6_i64, %2 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg2, %c_49_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg1, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.srem %c2_i64, %arg0 : i64
    %1 = llvm.srem %c0_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.xor %0, %c9_i64 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "sgt" %c_45_i64, %arg0 : i64
    %1 = llvm.select %0, %c6_i64, %arg0 : i1, i64
    %2 = llvm.sdiv %arg1, %1 : i64
    %3 = llvm.icmp "ult" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %arg0, %c1_i64 : i64
    %1 = llvm.urem %arg1, %c_20_i64 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.and %c_13_i64, %arg0 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %false, %1, %arg1 : i1, i64
    %3 = llvm.icmp "sle" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %c39_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.xor %2, %c_21_i64 : i64
    %4 = llvm.select %true, %0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.and %arg1, %arg1 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c4_i64 = arith.constant 4 : i64
    %true = arith.constant true
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.select %true, %c_47_i64, %arg0 : i1, i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.ashr %c4_i64, %1 : i64
    %3 = llvm.select %true, %2, %c8_i64 : i1, i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c45_i64 = arith.constant 45 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "sgt" %c_48_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %c45_i64, %1 : i64
    %3 = llvm.ashr %arg0, %c_8_i64 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "slt" %c_35_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "slt" %c_9_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_26_i64 = arith.constant -26 : i64
    %true = arith.constant true
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %true, %c38_i64, %arg0 : i1, i64
    %1 = llvm.lshr %c_26_i64, %0 : i64
    %2 = llvm.udiv %c9_i64, %arg1 : i64
    %3 = llvm.udiv %2, %arg1 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.and %arg0, %c_9_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.udiv %1, %c23_i64 : i64
    %3 = llvm.lshr %2, %0 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg2, %c21_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %c30_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %arg0, %c_13_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ult" %c21_i64, %c0_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %1, %arg0 : i1, i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.urem %0, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.icmp "eq" %c9_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.select %2, %arg0, %1 : i1, i64
    %4 = llvm.icmp "eq" %3, %c_30_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %arg0, %c40_i64 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %c_28_i64, %2 : i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c20_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c42_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %0, %arg1 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %c_50_i64, %c_37_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.or %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sgt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.select %0, %1, %arg2 : i1, i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.icmp "ugt" %c_49_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %arg0, %c19_i64 : i64
    %1 = llvm.udiv %c_47_i64, %0 : i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.xor %c32_i64, %c9_i64 : i64
    %3 = llvm.select %1, %arg2, %2 : i1, i64
    %4 = llvm.srem %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c4_i64 = arith.constant 4 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.urem %c_23_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c4_i64 : i64
    %2 = llvm.select %1, %c_14_i64, %c21_i64 : i1, i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ult" %c_16_i64, %c42_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %c25_i64, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c32_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sext %arg2 : i1 to i64
    %1 = llvm.icmp "sle" %0, %c_20_i64 : i64
    %2 = llvm.select %1, %c41_i64, %arg1 : i1, i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c37_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.lshr %arg1, %c_31_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.urem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "sle" %c_15_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.srem %c_2_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %arg1, %arg0 : i64
    %4 = llvm.icmp "eq" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %c30_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.sdiv %c43_i64, %0 : i64
    %4 = llvm.or %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %false = arith.constant false
    %c6_i64 = arith.constant 6 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.select %false, %c6_i64, %c5_i64 : i1, i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %c33_i64, %arg1 : i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %true = arith.constant true
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.urem %arg0, %c_17_i64 : i64
    %1 = llvm.select %true, %arg1, %arg2 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %0, %c_37_i64 : i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ult" %arg0, %c31_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %c4_i64 : i64
    %3 = llvm.trunc %0 : i1 to i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %c_50_i64 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %true = arith.constant true
    %c_47_i64 = arith.constant -47 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.select %true, %c_47_i64, %c_39_i64 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.or %c39_i64, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %c39_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.icmp "ult" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.icmp "ne" %c7_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c27_i64 : i64
    %2 = llvm.sdiv %1, %c7_i64 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.select %0, %c_8_i64, %2 : i1, i64
    %4 = llvm.lshr %3, %arg2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c7_i64 = arith.constant 7 : i64
    %c24_i64 = arith.constant 24 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %c8_i64, %arg0 : i64
    %1 = llvm.xor %c24_i64, %0 : i64
    %2 = llvm.sext %true : i1 to i64
    %3 = llvm.urem %c7_i64, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %c_43_i64 : i64
    %2 = llvm.udiv %c_16_i64, %arg0 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "ugt" %c24_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "eq" %2, %arg2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %c40_i64, %c_11_i64 : i64
    %1 = llvm.udiv %arg2, %c_42_i64 : i64
    %2 = llvm.select %arg1, %1, %c8_i64 : i1, i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %arg2, %c41_i64 : i64
    %2 = llvm.srem %c23_i64, %1 : i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.icmp "uge" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg2, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c_28_i64, %c_12_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %arg1, %c_26_i64 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.urem %1, %0 : i64
    %3 = llvm.trunc %false : i1 to i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c48_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %c48_i64 : i64
    %3 = llvm.sext %arg1 : i1 to i64
    %4 = llvm.select %2, %0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ne" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c42_i64 = arith.constant 42 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %c_21_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %c_24_i64 : i64
    %4 = llvm.icmp "sge" %c42_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %c12_i64, %0 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    %3 = llvm.sdiv %c7_i64, %arg1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c16_i64 = arith.constant 16 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.or %arg0, %c39_i64 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.urem %c16_i64, %c_21_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.urem %arg0, %c_22_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %arg1, %arg1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "eq" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "uge" %3, %c1_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %c_44_i64, %0 : i64
    %2 = llvm.sdiv %arg1, %arg2 : i64
    %3 = llvm.icmp "sle" %1, %2 : i64
    %4 = llvm.select %3, %c_28_i64, %c7_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.ashr %c_12_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.sdiv %1, %c44_i64 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "uge" %arg0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.icmp "eq" %c28_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c24_i64 = arith.constant 24 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c50_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c_16_i64, %arg0 : i64
    %2 = llvm.select %arg1, %arg0, %c15_i64 : i1, i64
    %3 = llvm.select %1, %c24_i64, %2 : i1, i64
    %4 = llvm.icmp "ugt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.urem %arg0, %c37_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.trunc %arg1 : i1 to i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.icmp "ule" %c_8_i64, %2 : i64
    %4 = llvm.select %3, %c_37_i64, %c42_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sgt" %c_15_i64, %arg0 : i64
    %1 = llvm.select %0, %arg1, %c49_i64 : i1, i64
    %2 = llvm.zext %0 : i1 to i64
    %3 = llvm.sdiv %arg2, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %arg2, %c_41_i64 : i64
    %2 = llvm.icmp "ult" %arg1, %1 : i64
    %3 = llvm.select %2, %arg2, %arg2 : i1, i64
    %4 = llvm.select %true, %0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.udiv %arg0, %c_13_i64 : i64
    %1 = llvm.icmp "ne" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.icmp "sge" %c22_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c3_i64 = arith.constant 3 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c10_i64, %1 : i64
    %3 = llvm.ashr %c3_i64, %c_49_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.lshr %arg0, %arg2 : i64
    %3 = llvm.or %2, %c44_i64 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %c50_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %c_26_i64, %c24_i64 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.srem %c34_i64, %1 : i64
    %3 = llvm.sdiv %2, %c_37_i64 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg1, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "uge" %c_34_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %c_1_i64 : i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.icmp "eq" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c0_i64 = arith.constant 0 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %c0_i64, %c35_i64 : i64
    %1 = llvm.icmp "sge" %arg1, %c29_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %arg0, %2, %2 : i1, i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.select %true, %0, %1 : i1, i64
    %3 = llvm.srem %c_18_i64, %2 : i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.icmp "sge" %c35_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.xor %1, %c38_i64 : i64
    %3 = llvm.lshr %2, %c1_i64 : i64
    %4 = llvm.icmp "sle" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ne" %arg0, %c_35_i64 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.sdiv %1, %c_36_i64 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.select %0, %3, %c15_i64 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %c_40_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.xor %0, %c28_i64 : i64
    %4 = llvm.icmp "ult" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.sdiv %c7_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c7_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.and %arg1, %c7_i64 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.lshr %1, %c_23_i64 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.and %3, %c_43_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.xor %arg1, %c16_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %arg1, %c_20_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c_11_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %c_36_i64 : i1, i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.and %2, %1 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.lshr %arg0, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ult" %3, %c_32_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %c_36_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.srem %1, %c33_i64 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %arg1, %c_5_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %true, %c_9_i64, %0 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.or %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c_9_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c3_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.select %1, %c_28_i64, %arg0 : i1, i64
    %3 = llvm.and %arg0, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %c_45_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.or %arg1, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.or %3, %c39_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %c19_i64 = arith.constant 19 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c41_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %c19_i64 : i64
    %2 = llvm.icmp "sgt" %1, %c_24_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %arg0, %arg1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.select %true, %arg0, %c_27_i64 : i1, i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.xor %c22_i64, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.icmp "sgt" %3, %c1_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.select %2, %3, %arg1 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c_17_i64, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %c11_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.urem %c26_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %c23_i64 : i1, i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.icmp "sgt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %c31_i64, %arg0 : i64
    %1 = llvm.sdiv %c35_i64, %0 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.select %arg1, %arg0, %1 : i1, i64
    %3 = llvm.ashr %c49_i64, %2 : i64
    %4 = llvm.icmp "sgt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_20_i64 = arith.constant -20 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %c_4_i64, %0 : i1, i64
    %2 = llvm.icmp "ult" %c_20_i64, %1 : i64
    %3 = llvm.select %2, %c_35_i64, %1 : i1, i64
    %4 = llvm.icmp "sle" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.icmp "slt" %c_49_i64, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.or %arg1, %arg0 : i64
    %3 = llvm.icmp "ule" %1, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %c15_i64, %c28_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %c_4_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c_9_i64, %c_23_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %2, %c37_i64 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %c_25_i64, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %c_49_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "ne" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.and %c_5_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.udiv %c_28_i64, %1 : i64
    %3 = llvm.urem %1, %c_47_i64 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.icmp "ne" %3, %c_41_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.srem %1, %arg1 : i64
    %3 = llvm.icmp "ugt" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %arg2, %c_42_i64 : i64
    %2 = llvm.and %c_4_i64, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %c23_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.icmp "ugt" %c_23_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "sle" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %c_36_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %0 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %c6_i64, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.xor %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.lshr %c_24_i64, %c20_i64 : i64
    %1 = llvm.srem %0, %c31_i64 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.icmp "slt" %1, %2 : i64
    %4 = llvm.trunc %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.xor %arg1, %c_21_i64 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %c12_i64, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "slt" %0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.srem %arg2, %0 : i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %arg1 : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.icmp "ugt" %c29_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %0, %1 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.xor %arg2, %1 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %c_27_i64, %c5_i64 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.srem %c41_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %c_20_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.ashr %c25_i64, %1 : i64
    %3 = llvm.lshr %arg0, %0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c47_i64 = arith.constant 47 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "slt" %c35_i64, %arg0 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.select %0, %c_33_i64, %1 : i1, i64
    %3 = llvm.icmp "eq" %c47_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %arg2 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "eq" %c_14_i64, %c_5_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %c29_i64 : i64
    %3 = llvm.ashr %c29_i64, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg1 : i64
    %2 = llvm.icmp "slt" %c22_i64, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %0, %3, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "sge" %arg2, %c_44_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.lshr %c_47_i64, %1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.xor %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %arg2, %arg1 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %arg1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_15_i64 = arith.constant -15 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.or %c_5_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c_15_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %c7_i64, %arg1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.lshr %3, %c4_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c_24_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %c_5_i64 : i64
    %2 = llvm.xor %arg0, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c40_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.srem %arg1, %arg1 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %c37_i64, %c_18_i64 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.urem %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.icmp "slt" %3, %arg2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.udiv %c44_i64, %1 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.sdiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %true = arith.constant true
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %c_27_i64 : i64
    %2 = llvm.select %true, %1, %1 : i1, i64
    %3 = llvm.sext %true : i1 to i64
    %4 = llvm.select %0, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.icmp "ult" %3, %c_33_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "uge" %arg0, %c15_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "ule" %c_44_i64, %c42_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c20_i64, %arg0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sle" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.lshr %0, %arg0 : i64
    %3 = llvm.select %1, %c8_i64, %2 : i1, i64
    %4 = llvm.icmp "slt" %3, %c_36_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg0, %arg1, %c46_i64 : i1, i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.icmp "sge" %1, %c_44_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.and %3, %c_42_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c33_i64 = arith.constant 33 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.or %c16_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ne" %1, %c33_i64 : i64
    %3 = llvm.select %2, %arg2, %c17_i64 : i1, i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.lshr %c_25_i64, %c_10_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %2, %c42_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %c42_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sge" %arg1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %3, %c_50_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.or %arg1, %2 : i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %c_49_i64 : i64
    %2 = llvm.srem %arg1, %c_47_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.icmp "ule" %c_43_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %false = arith.constant false
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.select %false, %c21_i64, %2 : i1, i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.select %arg1, %c_31_i64, %arg2 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.sext %arg1 : i1 to i64
    %3 = llvm.sdiv %c28_i64, %2 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "ugt" %c35_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.udiv %1, %1 : i64
    %4 = llvm.icmp "ule" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "ult" %c23_i64, %0 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.select %false, %2, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c_32_i64 = arith.constant -32 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %c_32_i64 : i64
    %4 = llvm.srem %3, %c46_i64 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %false, %arg2, %1 : i1, i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.udiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.udiv %c11_i64, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.icmp "slt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %c_4_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg2, %c27_i64 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ne" %c_49_i64, %c_6_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ne" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.icmp "eq" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "sge" %arg2, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ule" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.icmp "eq" %c2_i64, %c21_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.srem %c13_i64, %c43_i64 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "ult" %c11_i64, %c46_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %arg1 : i64
    %3 = llvm.select %2, %arg1, %arg1 : i1, i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %c_31_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "ule" %arg0, %c20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.select %arg1, %c_23_i64, %1 : i1, i64
    %3 = llvm.srem %2, %arg2 : i64
    %4 = llvm.icmp "ne" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %false = arith.constant false
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.lshr %c_26_i64, %arg0 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.select %0, %arg1, %2 : i1, i64
    %4 = llvm.select %false, %arg0, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.lshr %1, %c3_i64 : i64
    %3 = llvm.urem %c5_i64, %2 : i64
    %4 = llvm.select %arg0, %arg1, %3 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %c17_i64 : i64
    %3 = llvm.and %arg0, %2 : i64
    %4 = llvm.icmp "eq" %c13_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "ule" %c2_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %c_46_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.icmp "ne" %c_33_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.urem %arg2, %arg1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.sdiv %3, %arg0 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.trunc %false : i1 to i64
    %3 = llvm.or %2, %arg0 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c16_i64, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "ult" %3, %0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.select %arg1, %arg0, %c_4_i64 : i1, i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.or %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg1, %c_29_i64, %c_15_i64 : i1, i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %1, %c4_i64, %2 : i1, i64
    %4 = llvm.icmp "sgt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %true = arith.constant true
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.select %true, %arg0, %c_41_i64 : i1, i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.xor %1, %c50_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c36_i64 = arith.constant 36 : i64
    %c33_i64 = arith.constant 33 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "ule" %c17_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c33_i64, %1 : i64
    %3 = llvm.select %2, %c_27_i64, %arg1 : i1, i64
    %4 = llvm.icmp "ugt" %c36_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.xor %0, %c_39_i64 : i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.xor %c21_i64, %2 : i64
    %4 = llvm.icmp "sge" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c_2_i64, %c_38_i64 : i64
    %3 = llvm.select %2, %c35_i64, %1 : i1, i64
    %4 = llvm.and %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %c_36_i64 = arith.constant -36 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c_36_i64, %c_10_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.udiv %3, %arg1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %c22_i64, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sle" %arg1, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %c_28_i64, %c_43_i64 : i64
    %1 = llvm.ashr %0, %c25_i64 : i64
    %2 = llvm.icmp "ule" %arg0, %c22_i64 : i64
    %3 = llvm.trunc %2 : i1 to i64
    %4 = llvm.icmp "sge" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c_27_i64 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.srem %c_16_i64, %2 : i64
    %4 = llvm.icmp "ult" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.sdiv %0, %c8_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.and %c_4_i64, %c_18_i64 : i64
    %1 = llvm.srem %c33_i64, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.and %c_47_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %c36_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %c_9_i64, %1 : i64
    %3 = llvm.or %0, %arg0 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.urem %arg0, %c29_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.lshr %c22_i64, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
