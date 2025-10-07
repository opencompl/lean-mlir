module {
  func.func @main() -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.icmp "sle" %c_37_i64, %c17_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sgt" %c42_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %arg0, %c30_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %false = arith.constant false
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "uge" %1, %c24_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %c49_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %c47_i64, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %c25_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c34_i64 = arith.constant 34 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.select %false, %c34_i64, %c25_i64 : i1, i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %c32_i64, %arg1 : i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "ule" %c46_i64, %c_46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c_14_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.urem %c_1_i64, %c8_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "slt" %arg0, %c_21_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.srem %arg0, %c_4_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %c36_i64 = arith.constant 36 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "sge" %c36_i64, %c47_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c32_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "ule" %c_9_i64, %c_46_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %c_40_i64, %c_39_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %c46_i64, %c_14_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.srem %c42_i64, %arg0 : i64
    %1 = llvm.sdiv %c8_i64, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %arg0, %c_42_i64 : i64
    %1 = llvm.lshr %c_2_i64, %0 : i64
    %2 = llvm.or %c_17_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %c47_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %c16_i64, %c46_i64 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %c_50_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.icmp "sle" %arg0, %c42_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %arg0, %c_16_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.ashr %c44_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %c_29_i64, %arg0 : i64
    %1 = llvm.lshr %c_34_i64, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c20_i64, %0 : i64
    %2 = llvm.ashr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg2 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.lshr %c14_i64, %arg0 : i64
    %1 = llvm.and %c_50_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %arg1 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c_26_i64 = arith.constant -26 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %c_26_i64, %c_14_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    %2 = llvm.select %1, %arg0, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %c_13_i64 : i64
    %2 = llvm.and %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %c39_i64, %c_15_i64 : i64
    %1 = llvm.icmp "slt" %0, %c_17_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c_5_i64, %c24_i64 : i64
    %1 = llvm.urem %c25_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.and %arg0, %c_48_i64 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.lshr %c15_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %c_41_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c_21_i64 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %c_46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %c44_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.icmp "ule" %c24_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.select %0, %1, %c46_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %true = arith.constant true
    %c_23_i64 = arith.constant -23 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %c_23_i64, %c5_i64 : i64
    %1 = llvm.select %true, %0, %c_42_i64 : i1, i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %c0_i64, %c_39_i64 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "ne" %c_5_i64, %c49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_27_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.lshr %c48_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %c42_i64 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %c47_i64, %0 : i64
    %2 = llvm.icmp "uge" %c_7_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c_39_i64, %arg0 : i64
    %1 = llvm.sdiv %c41_i64, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %arg2 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "uge" %c_5_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ne" %c_21_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %c28_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.ashr %arg0, %c_28_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.and %c16_i64, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c_37_i64 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.srem %c24_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.sdiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "eq" %c_15_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.srem %c_30_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %c7_i64, %c_14_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.or %c_26_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.select %arg0, %arg1, %c_36_i64 : i1, i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    %2 = llvm.select %arg0, %1, %c34_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.ashr %arg0, %c_48_i64 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.urem %c_9_i64, %arg2 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %c22_i64, %c_2_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c_2_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %c43_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c10_i64 = arith.constant 10 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %c10_i64, %c_48_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.or %1, %c4_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.ashr %c_38_i64, %arg0 : i64
    %1 = llvm.udiv %c26_i64, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %false = arith.constant false
    %c35_i64 = arith.constant 35 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.select %false, %c35_i64, %c5_i64 : i1, i64
    %1 = llvm.xor %c14_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c_24_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.and %arg0, %c2_i64 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.srem %1, %c28_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sle" %c_43_i64, %c43_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %c50_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.srem %c_8_i64, %c_43_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.srem %1, %c_15_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %0, %c_24_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c3_i64 = arith.constant 3 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sge" %c3_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c14_i64 = arith.constant 14 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c14_i64, %c_8_i64 : i64
    %1 = llvm.srem %0, %c21_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.xor %c_24_i64, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %0, %c32_i64 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c13_i64 = arith.constant 13 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.icmp "ne" %c13_i64, %c33_i64 : i64
    %1 = llvm.select %0, %c_11_i64, %c_50_i64 : i1, i64
    %2 = llvm.icmp "eq" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.or %c_1_i64, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.udiv %c_12_i64, %c41_i64 : i64
    %1 = llvm.xor %c15_i64, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.and %1, %c45_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %c48_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %c_36_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c7_i64 = arith.constant 7 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sge" %c7_i64, %c29_i64 : i64
    %1 = llvm.select %0, %arg0, %c_8_i64 : i1, i64
    %2 = llvm.and %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "ult" %c19_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ne" %c11_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.select %1, %arg1, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %c_49_i64, %0 : i64
    %2 = llvm.icmp "ne" %c0_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %arg0, %c_50_i64 : i64
    %1 = llvm.srem %arg1, %c_26_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c_40_i64, %0 : i64
    %2 = llvm.icmp "eq" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c38_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.icmp "uge" %c41_i64, %c_46_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.xor %arg0, %c_36_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %c44_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %c_12_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "uge" %arg0, %c_7_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %c_42_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %arg0, %c24_i64 : i64
    %1 = llvm.ashr %0, %c36_i64 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c42_i64 : i64
    %2 = llvm.icmp "eq" %1, %c19_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c12_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "eq" %arg0, %c_20_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %c_19_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.and %c_46_i64, %c_23_i64 : i64
    %1 = llvm.sdiv %0, %c42_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.urem %c19_i64, %c_32_i64 : i64
    %1 = llvm.icmp "ult" %0, %c_31_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.icmp "ule" %c38_i64, %c_49_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c11_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.sdiv %0, %c22_i64 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "ne" %c_33_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %c_46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "sle" %c35_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.urem %c_10_i64, %c10_i64 : i64
    %1 = llvm.xor %c2_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %c_29_i64, %c_49_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c_19_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.icmp "uge" %c34_i64, %c2_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c2_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.xor %arg0, %c_13_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.udiv %1, %c0_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c25_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c50_i64 = arith.constant 50 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.udiv %c_8_i64, %c7_i64 : i64
    %1 = llvm.srem %0, %c_40_i64 : i64
    %2 = llvm.icmp "slt" %c50_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %c18_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %arg2, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "uge" %arg0, %c_13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %0, %c40_i64 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c37_i64 = arith.constant 37 : i64
    %c8_i64 = arith.constant 8 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %c8_i64, %c_28_i64 : i64
    %1 = llvm.ashr %0, %c37_i64 : i64
    %2 = llvm.icmp "sgt" %1, %c_25_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "ule" %c45_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %arg0 : i1, i64
    %2 = llvm.icmp "uge" %1, %c_40_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.ashr %c43_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %c39_i64 : i64
    %2 = llvm.urem %c7_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_43_i64 = arith.constant -43 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.ashr %c_43_i64, %c40_i64 : i64
    %1 = llvm.udiv %0, %c19_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %c_45_i64, %0 : i64
    %2 = llvm.icmp "uge" %c43_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.sdiv %c_25_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c22_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.urem %c_12_i64, %arg0 : i64
    %1 = llvm.and %c_31_i64, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %arg0, %c_34_i64, %c29_i64 : i1, i64
    %1 = llvm.srem %c40_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %c16_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.ashr %arg0, %c_13_i64 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %c_11_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c_8_i64 = arith.constant -8 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %c_49_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %c_8_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %c_50_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.or %arg0, %c_36_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c31_i64 = arith.constant 31 : i64
    %c28_i64 = arith.constant 28 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.urem %c28_i64, %c41_i64 : i64
    %1 = llvm.and %c31_i64, %0 : i64
    %2 = llvm.srem %c26_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c21_i64 = arith.constant 21 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "sle" %c21_i64, %c_24_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c39_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %c22_i64, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %c_44_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.icmp "ule" %1, %c17_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.select %arg0, %c26_i64, %arg1 : i1, i64
    %1 = llvm.and %c_46_i64, %c13_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %c35_i64 = arith.constant 35 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.xor %c35_i64, %c10_i64 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ne" %c_25_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.lshr %arg0, %c_12_i64 : i64
    %1 = llvm.urem %c_9_i64, %0 : i64
    %2 = llvm.icmp "uge" %c46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.udiv %c42_i64, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.lshr %c10_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c43_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.and %c_49_i64, %c8_i64 : i64
    %1 = llvm.lshr %c30_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c2_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.and %arg0, %c_26_i64 : i64
    %1 = llvm.udiv %arg1, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c43_i64 = arith.constant 43 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %c43_i64, %c26_i64 : i64
    %1 = llvm.srem %0, %c20_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c3_i64 = arith.constant 3 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.and %arg0, %c_13_i64 : i64
    %1 = llvm.or %0, %c_32_i64 : i64
    %2 = llvm.icmp "ugt" %c3_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_5_i64 = arith.constant -5 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %c_27_i64, %arg0 : i64
    %1 = llvm.or %0, %c_32_i64 : i64
    %2 = llvm.icmp "sle" %c_5_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.lshr %c_19_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c38_i64 = arith.constant 38 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c38_i64, %c48_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c36_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %c8_i64, %arg0 : i64
    %1 = llvm.udiv %c43_i64, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %c_36_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c43_i64 = arith.constant 43 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.urem %c43_i64, %c0_i64 : i64
    %1 = llvm.icmp "slt" %c15_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c0_i64, %0 : i64
    %2 = llvm.icmp "ult" %c40_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c9_i64 = arith.constant 9 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.udiv %c9_i64, %c_39_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.lshr %1, %c30_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.udiv %c39_i64, %c_2_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.srem %c16_i64, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %c_1_i64, %c14_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.and %c_15_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %c27_i64, %c17_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.udiv %c35_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %arg0, %c4_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.srem %c47_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c50_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sle" %c_41_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c14_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c27_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %c4_i64, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c_12_i64, %c_6_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c6_i64 = arith.constant 6 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.xor %c44_i64, %arg0 : i64
    %1 = llvm.urem %c6_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c_21_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %arg1, %c_47_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %c_11_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.or %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %0, %c_47_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %c_35_i64, %c_35_i64 : i64
    %1 = llvm.srem %0, %c45_i64 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %c25_i64, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.udiv %c33_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c_42_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.sdiv %c_19_i64, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.icmp "sge" %1, %c_42_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.or %c_48_i64, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c16_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.urem %arg0, %c39_i64 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.select %false, %c41_i64, %c16_i64 : i1, i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "sgt" %c13_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.and %arg0, %c_29_i64 : i64
    %1 = llvm.ashr %arg0, %c_4_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %c31_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %c14_i64 = arith.constant 14 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.xor %c14_i64, %c_9_i64 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sle" %c_36_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %arg0, %c44_i64 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.icmp "sge" %c46_i64, %c_29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c42_i64 = arith.constant 42 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %c42_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.or %c_45_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.udiv %c23_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %c44_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.ashr %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "slt" %c40_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "ule" %c45_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c_2_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ne" %c_38_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c11_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c23_i64 = arith.constant 23 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sdiv %c23_i64, %c_13_i64 : i64
    %1 = llvm.select %true, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.and %arg0, %c16_i64 : i64
    %1 = llvm.xor %0, %c_34_i64 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c_21_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c47_i64 = arith.constant 47 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %c_21_i64, %arg0 : i64
    %1 = llvm.ashr %c_32_i64, %0 : i64
    %2 = llvm.ashr %c47_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg2 : i1, i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %c41_i64, %c24_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.select %arg0, %c_24_i64, %arg1 : i1, i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %1, %c_28_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %arg0, %c_13_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.urem %c44_i64, %arg0 : i64
    %1 = llvm.and %c_43_i64, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c_13_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %c41_i64, %arg1 : i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.lshr %arg0, %c_28_i64 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.urem %arg0, %c33_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c_40_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %c29_i64, %arg0 : i64
    %1 = llvm.ashr %0, %c_34_i64 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.and %c2_i64, %c_6_i64 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c48_i64 = arith.constant 48 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %c16_i64, %arg0 : i64
    %1 = llvm.sdiv %c48_i64, %c_28_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %c_22_i64, %arg1 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sdiv %c29_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c_10_i64 = arith.constant -10 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "eq" %c_10_i64, %c_2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %c43_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "sge" %c_1_i64, %c_23_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg1, %arg2 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.select %true, %c12_i64, %arg0 : i1, i64
    %1 = llvm.or %c49_i64, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.sdiv %c_18_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_46_i64 = arith.constant -46 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %c_35_i64, %c10_i64 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sge" %c_46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c_22_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %c15_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c_48_i64 = arith.constant -48 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sle" %c_48_i64, %c_26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c_31_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c48_i64 = arith.constant 48 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ule" %c48_i64, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c_27_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c36_i64 : i64
    %2 = llvm.ashr %c40_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c19_i64 = arith.constant 19 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "sgt" %c19_i64, %c31_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c35_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "ugt" %c48_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.xor %c1_i64, %c11_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.xor %c_42_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "slt" %c40_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "sgt" %arg1, %c_26_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %c_43_i64, %arg0 : i64
    %1 = llvm.srem %c46_i64, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.icmp "eq" %c35_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c26_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.sdiv %arg0, %c_44_i64 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %c_38_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.xor %c_22_i64, %c47_i64 : i64
    %1 = llvm.icmp "eq" %c_44_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.srem %arg0, %c17_i64 : i64
    %1 = llvm.icmp "eq" %0, %c_29_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c20_i64 = arith.constant 20 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.lshr %c9_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c20_i64, %0 : i64
    %2 = llvm.select %1, %c_10_i64, %0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.srem %arg1, %arg1 : i64
    %1 = llvm.srem %0, %arg2 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %arg0, %c46_i64 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.udiv %c8_i64, %c_18_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "uge" %c_47_i64, %c_18_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %c31_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.icmp "uge" %c_1_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %c11_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg2 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %0, %c10_i64 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c_50_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c30_i64 = arith.constant 30 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "uge" %c43_i64, %arg0 : i64
    %1 = llvm.select %0, %c_46_i64, %arg0 : i1, i64
    %2 = llvm.udiv %c30_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.ashr %c_38_i64, %c_32_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c18_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.select %true, %arg0, %c_27_i64 : i1, i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %c_48_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "sge" %c46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.urem %c8_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c_7_i64, %c49_i64 : i64
    %1 = llvm.icmp "ule" %0, %c_7_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "ult" %c40_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.srem %c_49_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %c_50_i64, %0 : i64
    %2 = llvm.icmp "ule" %c_48_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %c50_i64, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %c47_i64, %0 : i64
    %2 = llvm.or %c38_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_19_i64 = arith.constant -19 : i64
    %c3_i64 = arith.constant 3 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.udiv %c3_i64, %c47_i64 : i64
    %1 = llvm.ashr %c_19_i64, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %c31_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %c_21_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %c_30_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c_1_i64 = arith.constant -1 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "eq" %c_1_i64, %c_43_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c35_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %c17_i64, %0 : i64
    %2 = llvm.icmp "ule" %c_24_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.xor %c_26_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c22_i64, %c_35_i64 : i64
    %1 = llvm.icmp "eq" %c_43_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %c45_i64 : i1, i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c1_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c4_i64 = arith.constant 4 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ule" %c4_i64, %c5_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c28_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %1, %c_11_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c_28_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %c_4_i64 : i64
    %2 = llvm.icmp "ult" %c45_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.udiv %0, %c7_i64 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.xor %0, %c_33_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %true = arith.constant true
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.select %true, %arg1, %c_10_i64 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "slt" %c_37_i64, %c_2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %c_26_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.select %arg1, %c7_i64, %c18_i64 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.srem %c36_i64, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ule" %c_23_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %c7_i64, %c_48_i64 : i64
    %1 = llvm.urem %c_50_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c12_i64 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c3_i64 = arith.constant 3 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "sle" %c28_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %true, %c3_i64, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %arg0, %c_39_i64 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c2_i64 = arith.constant 2 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %c2_i64, %c_33_i64 : i64
    %1 = llvm.sdiv %c45_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.select %arg0, %c41_i64, %arg1 : i1, i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c8_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c16_i64 = arith.constant 16 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.and %c16_i64, %c_19_i64 : i64
    %1 = llvm.xor %c0_i64, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %c_38_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %c_33_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "uge" %arg0, %c_27_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %c10_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.select %false, %arg0, %c_31_i64 : i1, i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "ne" %c_27_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.icmp "ne" %c22_i64, %c_32_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sgt" %arg0, %c43_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "ult" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %c14_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.or %c_27_i64, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.or %1, %c22_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.lshr %c37_i64, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %false = arith.constant false
    %c_1_i64 = arith.constant -1 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %c_1_i64, %c46_i64 : i64
    %1 = llvm.select %false, %0, %0 : i1, i64
    %2 = llvm.icmp "slt" %c_36_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %c_32_i64, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c_16_i64 = arith.constant -16 : i64
    %true = arith.constant true
    %c_30_i64 = arith.constant -30 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.select %true, %c_30_i64, %c_12_i64 : i1, i64
    %1 = llvm.sdiv %c_16_i64, %0 : i64
    %2 = llvm.urem %c5_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %c40_i64 = arith.constant 40 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.icmp "slt" %c40_i64, %c_14_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c_11_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %c_38_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %c40_i64, %arg0 : i64
    %1 = llvm.lshr %c_18_i64, %0 : i64
    %2 = llvm.icmp "ult" %c_15_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.urem %c36_i64, %c9_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %c32_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c_15_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.xor %c_14_i64, %arg0 : i64
    %1 = llvm.udiv %c_2_i64, %0 : i64
    %2 = llvm.icmp "ne" %c36_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.urem %c50_i64, %c21_i64 : i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.sdiv %arg1, %c_38_i64 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "ugt" %c_45_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c47_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "sge" %c20_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %c31_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %c_11_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c_7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c_7_i64, %0 : i64
    %2 = llvm.icmp "eq" %c_21_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.srem %c_5_i64, %c19_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.and %c35_i64, %0 : i64
    %2 = llvm.icmp "uge" %c39_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.and %c_15_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %c8_i64 : i1, i64
    %2 = llvm.icmp "ult" %c27_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.urem %c_27_i64, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.udiv %c_27_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c_40_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sge" %c4_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_47_i64 = arith.constant -47 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.icmp "sle" %c_47_i64, %c_25_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.sdiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sge" %c_6_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %c26_i64, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %1, %c_26_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "slt" %c_41_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %c46_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sgt" %arg1, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.lshr %c_45_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.lshr %arg0, %c_40_i64 : i64
    %1 = llvm.sdiv %c39_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c35_i64 = arith.constant 35 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "ule" %c35_i64, %c50_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c_24_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %true = arith.constant true
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.select %true, %c_50_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "ult" %c22_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c_33_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c38_i64 = arith.constant 38 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sle" %c38_i64, %c43_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.lshr %c_30_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %arg0, %c45_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.udiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sdiv %arg2, %c_41_i64 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c19_i64 = arith.constant 19 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.ashr %c19_i64, %c_25_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ult" %c_22_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c_44_i64, %arg1 : i1, i64
    %2 = llvm.icmp "sgt" %c29_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.icmp "ule" %arg0, %c5_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "slt" %1, %c2_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.select %true, %arg0, %c42_i64 : i1, i64
    %1 = llvm.and %c_22_i64, %0 : i64
    %2 = llvm.srem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "slt" %c_7_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %c_30_i64, %c_16_i64 : i64
    %1 = llvm.icmp "ugt" %c_25_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %c18_i64, %c_14_i64 : i1, i64
    %1 = llvm.urem %c_28_i64, %0 : i64
    %2 = llvm.udiv %1, %c_34_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %false = arith.constant false
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.select %false, %c_34_i64, %arg0 : i1, i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %c_2_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c15_i64 = arith.constant 15 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.or %c_12_i64, %arg0 : i64
    %1 = llvm.lshr %c15_i64, %c_3_i64 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.srem %c17_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %c_29_i64, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.urem %0, %c20_i64 : i64
    %2 = llvm.icmp "sgt" %c6_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %arg0, %c_33_i64 : i64
    %1 = llvm.ashr %c_26_i64, %c_27_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.icmp "slt" %c_37_i64, %c32_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c_25_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.urem %c_7_i64, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c_23_i64 = arith.constant -23 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %c_23_i64, %0 : i64
    %2 = llvm.icmp "ne" %c8_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.and %c_40_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %c20_i64, %c36_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %c37_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c45_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.or %c_43_i64, %arg0 : i64
    %1 = llvm.urem %c_27_i64, %0 : i64
    %2 = llvm.srem %1, %c22_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.icmp "sle" %c5_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c24_i64 = arith.constant 24 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.icmp "ugt" %c24_i64, %c0_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c_17_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %c_32_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.select %arg0, %0, %c2_i64 : i1, i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.sdiv %c33_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %c26_i64 : i64
    %1 = llvm.udiv %c_40_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c_31_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.and %arg2, %c_41_i64 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.icmp "uge" %c_9_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %c_33_i64 = arith.constant -33 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.or %arg0, %c23_i64 : i64
    %1 = llvm.xor %c_33_i64, %0 : i64
    %2 = llvm.udiv %c_15_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.srem %c22_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c40_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c_35_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "slt" %c1_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %arg0 : i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.select %true, %c33_i64, %arg0 : i1, i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c20_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %c43_i64, %c46_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "sgt" %c_8_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_40_i64 = arith.constant -40 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %c4_i64, %0 : i64
    %2 = llvm.ashr %c_40_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %c12_i64, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.icmp "ult" %c_36_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg1 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg2 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.select %false, %c_31_i64, %arg0 : i1, i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.udiv %c49_i64, %0 : i64
    %2 = llvm.or %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c17_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %c_3_i64, %0 : i64
    %2 = llvm.or %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.or %c48_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c49_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.select %true, %arg0, %c_22_i64 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.xor %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c38_i64 = arith.constant 38 : i64
    %c_4_i64 = arith.constant -4 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c_4_i64, %c_46_i64 : i64
    %1 = llvm.sdiv %c38_i64, %0 : i64
    %2 = llvm.icmp "ne" %c_42_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c33_i64 = arith.constant 33 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sle" %c33_i64, %c46_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.srem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %c_15_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "sgt" %c_22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %c_43_i64, %arg0 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.or %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "uge" %c_3_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c48_i64 = arith.constant 48 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "ult" %c48_i64, %c25_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ule" %c_23_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.or %c_25_i64, %arg0 : i64
    %1 = llvm.sdiv %c_8_i64, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %false = arith.constant false
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %false : i1 to i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "eq" %1, %c_24_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c10_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.or %c7_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c_31_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %c_44_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.icmp "sle" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.udiv %c_47_i64, %arg0 : i64
    %1 = llvm.urem %0, %c_26_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "ne" %arg0, %c13_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.urem %c_15_i64, %arg0 : i64
    %1 = llvm.select %false, %arg1, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg2 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "ne" %c30_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg1, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.icmp "ult" %c7_i64, %c47_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.udiv %arg0, %c_43_i64 : i64
    %1 = llvm.sdiv %c32_i64, %c27_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c8_i64 = arith.constant 8 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg0, %c_21_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.srem %c8_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.ashr %1, %c_33_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %c12_i64, %arg0 : i64
    %1 = llvm.udiv %c_34_i64, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %true = arith.constant true
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.select %true, %arg0, %c_38_i64 : i1, i64
    %1 = llvm.sdiv %arg0, %c36_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c42_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_42_i64 = arith.constant -42 : i64
    %c_46_i64 = arith.constant -46 : i64
    %true = arith.constant true
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %true, %c47_i64, %arg0 : i1, i64
    %1 = llvm.or %c_46_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c_42_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %arg0, %c_24_i64 : i64
    %1 = llvm.or %c_32_i64, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.ashr %c_23_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.icmp "ne" %c_21_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c_12_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %c_35_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "sgt" %c4_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_34_i64 = arith.constant -34 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.ashr %c_15_i64, %arg0 : i64
    %1 = llvm.select %false, %c_34_i64, %0 : i1, i64
    %2 = llvm.ashr %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c_15_i64 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.select %1, %c_5_i64, %arg0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %c34_i64, %arg1 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c_38_i64 = arith.constant -38 : i64
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.lshr %c_27_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %c_49_i64 : i64
    %2 = llvm.icmp "ne" %c_38_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "slt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ult" %c28_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c7_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.ashr %c_32_i64, %c_33_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.xor %c_18_i64, %arg0 : i64
    %1 = llvm.or %c_1_i64, %arg0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %false = arith.constant false
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.sdiv %arg0, %c_22_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %false, %1, %c25_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.lshr %c37_i64, %arg1 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.sdiv %arg0, %c22_i64 : i64
    %1 = llvm.icmp "ule" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_28_i64 = arith.constant -28 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.sdiv %c_28_i64, %c0_i64 : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %c_39_i64, %c_35_i64 : i64
    %1 = llvm.udiv %0, %c19_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ult" %c39_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.icmp "sle" %arg0, %c40_i64 : i64
    %1 = llvm.select %0, %c21_i64, %arg0 : i1, i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg1 : i1, i64
    %1 = llvm.urem %c_3_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_22_i64, %arg1 : i1, i64
    %2 = llvm.icmp "ule" %1, %c13_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.udiv %c21_i64, %arg0 : i64
    %1 = llvm.select %arg1, %c_49_i64, %0 : i1, i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %c_45_i64, %arg0 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_24_i64 = arith.constant -24 : i64
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %c_24_i64, %c_37_i64 : i64
    %1 = llvm.or %c_48_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_15_i64 = arith.constant -15 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.ashr %c_2_i64, %c_15_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.lshr %arg0, %c12_i64 : i64
    %1 = llvm.and %arg1, %c_4_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c30_i64 = arith.constant 30 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %c_8_i64, %arg0 : i64
    %1 = llvm.sdiv %c30_i64, %c_44_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "ugt" %c_2_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %c46_i64, %c_33_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %false = arith.constant false
    %c47_i64 = arith.constant 47 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %c47_i64, %c43_i64 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.select %false, %0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %0, %c_10_i64 : i64
    %2 = llvm.and %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.icmp "uge" %1, %c50_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %false = arith.constant false
    %c2_i64 = arith.constant 2 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.select %false, %c2_i64, %c36_i64 : i1, i64
    %1 = llvm.select %arg0, %0, %c_43_i64 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %c4_i64 : i64
    %2 = llvm.select %1, %arg1, %arg2 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.udiv %c_45_i64, %c_50_i64 : i64
    %1 = llvm.or %c_6_i64, %arg0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %arg1, %c5_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %c_29_i64, %arg0 : i64
    %1 = llvm.lshr %c42_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.and %arg0, %c_9_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.srem %c_19_i64, %arg0 : i64
    %1 = llvm.srem %c_20_i64, %0 : i64
    %2 = llvm.icmp "ugt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.select %1, %arg1, %0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %c_39_i64 = arith.constant -39 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c_39_i64, %c49_i64 : i64
    %1 = llvm.icmp "sgt" %0, %c44_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %c4_i64, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c_27_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %c_12_i64 = arith.constant -12 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %c_12_i64, %0 : i64
    %2 = llvm.icmp "sgt" %c29_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.ashr %c28_i64, %0 : i64
    %2 = llvm.icmp "sgt" %1, %c_19_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c_11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg0, %c_11_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %c_30_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "uge" %c3_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.select %arg2, %arg1, %arg1 : i1, i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c33_i64 : i64
    %2 = llvm.icmp "sgt" %1, %c35_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.udiv %1, %c50_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.udiv %c_50_i64, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c_48_i64, %c40_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.xor %arg0, %c_19_i64 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ule" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %arg2, %c_10_i64 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.lshr %c1_i64, %c_29_i64 : i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %c27_i64, %0 : i64
    %2 = llvm.xor %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %c_16_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "slt" %c_35_i64, %c43_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %1, %c28_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c_20_i64, %0 : i64
    %2 = llvm.srem %1, %c6_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %arg0, %c_50_i64 : i64
    %1 = llvm.xor %arg0, %c0_i64 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "ugt" %1, %c34_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %true = arith.constant true
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg2, %c7_i64 : i1, i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.xor %c_7_i64, %c_17_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.icmp "ugt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.sdiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.xor %c_46_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %arg0, %c9_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c_27_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.or %c_17_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.icmp "sge" %c_47_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "eq" %c_48_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.sdiv %c_6_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %c22_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_44_i64 = arith.constant -44 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %c_44_i64, %c_8_i64 : i64
    %1 = llvm.icmp "uge" %c22_i64, %0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.icmp "sge" %c43_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_27_i64 = arith.constant -27 : i64
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.icmp "eq" %c_27_i64, %c_8_i64 : i64
    %1 = llvm.udiv %c_16_i64, %c_34_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.xor %arg0, %c_35_i64 : i64
    %1 = llvm.urem %arg0, %arg0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.lshr %c11_i64, %c30_i64 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_45_i64 = arith.constant -45 : i64
    %c21_i64 = arith.constant 21 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "sle" %c21_i64, %c44_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c_45_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.icmp "sgt" %c48_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.sdiv %c_10_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c_11_i64 = arith.constant -11 : i64
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "sgt" %c_11_i64, %c19_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c_7_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.or %c_29_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "ult" %c0_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c18_i64 = arith.constant 18 : i64
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.icmp "ult" %c_15_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c27_i64 : i1, i64
    %2 = llvm.icmp "uge" %c18_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "slt" %1, %arg2 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.ashr %c_26_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %c_31_i64, %c20_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.select %arg0, %c_31_i64, %arg1 : i1, i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %c0_i64 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c25_i64 = arith.constant 25 : i64
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.or %c_5_i64, %arg0 : i64
    %1 = llvm.and %0, %c16_i64 : i64
    %2 = llvm.icmp "sgt" %c25_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.icmp "ule" %c_22_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "sle" %c2_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c15_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "uge" %c14_i64, %c_34_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.icmp "sgt" %c46_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ult" %c10_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.srem %c15_i64, %arg1 : i64
    %1 = llvm.sdiv %c_41_i64, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %c_43_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %c_40_i64, %0 : i64
    %2 = llvm.icmp "sge" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_48_i64 = arith.constant -48 : i64
    %c39_i64 = arith.constant 39 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %arg0, %c_3_i64 : i64
    %1 = llvm.sdiv %c39_i64, %0 : i64
    %2 = llvm.ashr %1, %c_48_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "slt" %c35_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c15_i64 = arith.constant 15 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %c15_i64, %c0_i64 : i64
    %1 = llvm.and %0, %c1_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %c_34_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.and %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c10_i64 = arith.constant 10 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.icmp "slt" %c4_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %c10_i64 : i1, i64
    %2 = llvm.and %1, %c_29_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %c_45_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.lshr %c_22_i64, %c_39_i64 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.lshr %c_5_i64, %arg0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %true = arith.constant true
    %c5_i64 = arith.constant 5 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c5_i64, %c26_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %arg0, %c16_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %c6_i64, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "ult" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.select %arg0, %c_38_i64, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.or %c21_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.and %arg0, %c29_i64 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c_31_i64 : i64
    %2 = llvm.icmp "ne" %c30_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.srem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c_14_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %c15_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %c_2_i64, %c38_i64 : i64
    %1 = llvm.or %c_26_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "ne" %c9_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %c10_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.urem %c15_i64, %arg0 : i64
    %1 = llvm.ashr %c2_i64, %arg0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.srem %arg0, %c39_i64 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_30_i64 = arith.constant -30 : i64
    %c_8_i64 = arith.constant -8 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.xor %c_8_i64, %0 : i64
    %2 = llvm.or %1, %c_30_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "slt" %c_30_i64, %c_23_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c0_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c7_i64 = arith.constant 7 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c7_i64, %c14_i64 : i64
    %1 = llvm.icmp "sge" %c_50_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.icmp "sge" %c_18_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %c_18_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_46_i64 = arith.constant -46 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.or %c_49_i64, %arg1 : i64
    %1 = llvm.urem %0, %c_46_i64 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_24_i64 = arith.constant -24 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sge" %c_24_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.select %0, %c13_i64, %c_34_i64 : i1, i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c49_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.or %arg1, %c48_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.and %1, %c_10_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %c_14_i64 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.sdiv %arg0, %c_14_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.select %arg0, %c29_i64, %arg1 : i1, i64
    %1 = llvm.icmp "sge" %0, %c_27_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %c_20_i64, %0 : i64
    %2 = llvm.icmp "ne" %c_35_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %c_7_i64, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %arg1, %c20_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.xor %c_17_i64, %c39_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.xor %c_39_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.sdiv %c_8_i64, %c_36_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %c43_i64, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %arg0, %c_46_i64 : i64
    %1 = llvm.icmp "ult" %c46_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.xor %c_28_i64, %c14_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c6_i64 : i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.udiv %c22_i64, %c12_i64 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %c_42_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.and %c7_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_3_i64 = arith.constant -3 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %c_3_i64, %c32_i64 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.ashr %c13_i64, %arg0 : i64
    %1 = llvm.icmp "sge" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg0, %c_27_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.and %c_28_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %c_4_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.and %c26_i64, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.trunc %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c33_i64 = arith.constant 33 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.xor %c33_i64, %c_12_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c_43_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c1_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c_14_i64 = arith.constant -14 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.and %c_14_i64, %c3_i64 : i64
    %1 = llvm.or %0, %c_13_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.xor %c22_i64, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.ashr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c_6_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %c6_i64 = arith.constant 6 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.select %arg0, %c_42_i64, %arg1 : i1, i64
    %1 = llvm.sdiv %0, %c6_i64 : i64
    %2 = llvm.icmp "ugt" %1, %c16_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.or %c_7_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_15_i64 = arith.constant -15 : i64
    %0 = llvm.or %c_15_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c32_i64 = arith.constant 32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.icmp "eq" %c32_i64, %c1_i64 : i64
    %1 = llvm.select %0, %arg0, %c_4_i64 : i1, i64
    %2 = llvm.sdiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.or %c_20_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c20_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %true = arith.constant true
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.select %true, %arg0, %c32_i64 : i1, i64
    %1 = llvm.icmp "ule" %c46_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %c32_i64 : i64
    %1 = llvm.icmp "ne" %0, %c10_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.or %c_2_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "uge" %arg1, %c38_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.select %arg2, %arg1, %arg0 : i1, i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "ule" %c26_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %c4_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "uge" %c_34_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c20_i64 = arith.constant 20 : i64
    %c46_i64 = arith.constant 46 : i64
    %c41_i64 = arith.constant 41 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.ashr %c41_i64, %c22_i64 : i64
    %1 = llvm.udiv %0, %c20_i64 : i64
    %2 = llvm.icmp "sle" %c46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.icmp "ule" %c28_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.icmp "ne" %c8_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.srem %c_29_i64, %c8_i64 : i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c36_i64 = arith.constant 36 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "uge" %arg0, %c_19_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c36_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ule" %1, %c_28_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %c40_i64, %0 : i64
    %2 = llvm.icmp "ule" %1, %0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c7_i64 = arith.constant 7 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.or %c7_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %c_27_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %arg0, %c34_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.or %c27_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ne" %1, %c8_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "uge" %c_31_i64, %c27_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "sgt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.and %c_32_i64, %c1_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %c_41_i64, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.urem %arg0, %c_34_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "slt" %c_43_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_1_i64 = arith.constant -1 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %c_1_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %0, %arg0 : i64
    %2 = llvm.and %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_37_i64 = arith.constant -37 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.lshr %c_37_i64, %c18_i64 : i64
    %1 = llvm.icmp "ult" %c4_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.icmp "eq" %c_4_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.xor %c9_i64, %c_10_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c11_i64, %arg1 : i1, i64
    %2 = llvm.ashr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_41_i64 = arith.constant -41 : i64
    %c_28_i64 = arith.constant -28 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ult" %c_28_i64, %c44_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c_41_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c48_i64 = arith.constant 48 : i64
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.and %c48_i64, %c_2_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %c_21_i64 = arith.constant -21 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.or %c_9_i64, %arg0 : i64
    %1 = llvm.and %c_21_i64, %c_27_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.ashr %c29_i64, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %c_50_i64 = arith.constant -50 : i64
    %0 = llvm.urem %c_50_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %c45_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.urem %arg0, %c_29_i64 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.select %true, %arg1, %c19_i64 : i1, i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.and %c_10_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.sdiv %c_46_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %c2_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %c45_i64, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %c_10_i64, %c30_i64 : i64
    %2 = llvm.or %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %0 = llvm.select %arg0, %arg2, %c_36_i64 : i1, i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c45_i64 = arith.constant 45 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %0, %c45_i64 : i64
    %2 = llvm.icmp "eq" %1, %c_43_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.urem %c12_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %c9_i64 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_36_i64 = arith.constant -36 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.xor %c_21_i64, %arg0 : i64
    %1 = llvm.ashr %c_36_i64, %0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %c_8_i64 : i64
    %2 = llvm.icmp "uge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_21_i64 = arith.constant -21 : i64
    %0 = llvm.srem %c_42_i64, %c_21_i64 : i64
    %1 = llvm.or %0, %c0_i64 : i64
    %2 = llvm.icmp "uge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "ule" %c25_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %arg1, %c_23_i64 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %c_33_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "uge" %c_16_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %arg2, %c31_i64 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %c34_i64, %0 : i64
    %2 = llvm.select %1, %c10_i64, %arg1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.icmp "sle" %c_40_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.and %c22_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_18_i64 = arith.constant -18 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.srem %c_18_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.lshr %c49_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.lshr %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_21_i64 = arith.constant -21 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %c35_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %c_7_i64, %0 : i64
    %2 = llvm.select %1, %arg0, %c_21_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_23_i64 = arith.constant -23 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.lshr %c_23_i64, %c42_i64 : i64
    %1 = llvm.icmp "sge" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c_37_i64 = arith.constant -37 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.sdiv %c_37_i64, %c50_i64 : i64
    %1 = llvm.select %false, %arg1, %0 : i1, i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.and %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %c_39_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %c_31_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.sdiv %c37_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.icmp "eq" %c_8_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %c13_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "ugt" %arg0, %c_13_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.icmp "slt" %arg0, %c20_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "slt" %1, %c26_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c28_i64 = arith.constant 28 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.lshr %c28_i64, %c1_i64 : i64
    %1 = llvm.icmp "uge" %c18_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.and %arg0, %c_27_i64 : i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.or %c24_i64, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c47_i64 = arith.constant 47 : i64
    %c46_i64 = arith.constant 46 : i64
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.icmp "sle" %arg0, %c8_i64 : i64
    %1 = llvm.select %0, %c47_i64, %arg0 : i1, i64
    %2 = llvm.icmp "ult" %c46_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_4_i64 = arith.constant -4 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.select %0, %c_4_i64, %arg1 : i1, i64
    %2 = llvm.lshr %c12_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %c12_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.select %0, %arg1, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_32_i64 = arith.constant -32 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %c44_i64, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    %2 = llvm.and %c_32_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %true = arith.constant true
    %c_49_i64 = arith.constant -49 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %c_49_i64, %c41_i64 : i64
    %1 = llvm.select %true, %0, %0 : i1, i64
    %2 = llvm.icmp "sge" %c17_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.select %false, %c_13_i64, %arg0 : i1, i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c_19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sle" %c_19_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c21_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg1 : i1, i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.udiv %arg0, %c44_i64 : i64
    %1 = llvm.trunc %arg1 : i1 to i64
    %2 = llvm.xor %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %c32_i64 = arith.constant 32 : i64
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.udiv %c32_i64, %c_29_i64 : i64
    %1 = llvm.urem %c_1_i64, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.icmp "uge" %c_23_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ugt" %c_43_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %false = arith.constant false
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.select %false, %0, %c15_i64 : i1, i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.srem %c9_i64, %c_6_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %c32_i64 : i64
    %2 = llvm.icmp "sle" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %0 = llvm.select %arg1, %c_37_i64, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c_22_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sge" %0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_38_i64 = arith.constant -38 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %c11_i64, %0 : i64
    %2 = llvm.ashr %c_38_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "sge" %c29_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.and %1, %arg0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c16_i64 = arith.constant 16 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.lshr %c16_i64, %c3_i64 : i64
    %1 = llvm.icmp "ne" %0, %c16_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ult" %c_6_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.urem %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.icmp "ult" %0, %c_14_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.srem %c29_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.icmp "uge" %arg0, %c_48_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ne" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.and %arg0, %c49_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ugt" %c_29_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_9_i64 = arith.constant -9 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "eq" %c_12_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %c_9_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c44_i64 = arith.constant 44 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "sgt" %0, %c44_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %false = arith.constant false
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %false, %arg0, %0 : i1, i64
    %2 = llvm.udiv %1, %arg2 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_22_i64 = arith.constant -22 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "ule" %c_22_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c_45_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c_18_i64 = arith.constant -18 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %c_18_i64, %c14_i64 : i64
    %1 = llvm.udiv %0, %c5_i64 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_22_i64 = arith.constant -22 : i64
    %c25_i64 = arith.constant 25 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %c25_i64, %c31_i64 : i64
    %1 = llvm.lshr %0, %c_22_i64 : i64
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %c25_i64 = arith.constant 25 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.xor %c25_i64, %c23_i64 : i64
    %1 = llvm.icmp "uge" %0, %c_8_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "sgt" %c26_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ugt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %c8_i64 = arith.constant 8 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.select %true, %c8_i64, %c2_i64 : i1, i64
    %1 = llvm.srem %0, %c0_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %c18_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c21_i64 = arith.constant 21 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.xor %c21_i64, %c45_i64 : i64
    %1 = llvm.icmp "ugt" %c4_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.or %c1_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %arg0, %c5_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ule" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.udiv %c24_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.or %c_17_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %0 = llvm.srem %c_33_i64, %arg0 : i64
    %1 = llvm.and %arg1, %0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.icmp "uge" %c_49_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_29_i64 = arith.constant -29 : i64
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %c_29_i64, %c_14_i64 : i1, i64
    %1 = llvm.sext %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c_30_i64 = arith.constant -30 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %c_30_i64, %c_13_i64 : i64
    %1 = llvm.icmp "sle" %c25_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.ashr %arg0, %c39_i64 : i64
    %1 = llvm.lshr %c12_i64, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "sgt" %c_20_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %true : i1 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_2_i64 = arith.constant -2 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.icmp "ule" %c31_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "ne" %c_2_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.lshr %c_31_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c_8_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.icmp "ule" %c_39_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "uge" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c_31_i64 = arith.constant -31 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.udiv %arg0, %c29_i64 : i64
    %1 = llvm.urem %c_31_i64, %0 : i64
    %2 = llvm.icmp "ule" %c25_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.or %c12_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "ule" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.sdiv %c35_i64, %arg0 : i64
    %1 = llvm.sdiv %c25_i64, %0 : i64
    %2 = llvm.udiv %1, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c28_i64 = arith.constant 28 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.icmp "sgt" %c28_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_49_i64 = arith.constant -49 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.icmp "sge" %1, %c_49_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %c38_i64 = arith.constant 38 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %c38_i64, %c27_i64 : i64
    %1 = llvm.srem %c40_i64, %0 : i64
    %2 = llvm.icmp "slt" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %c_7_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c15_i64 : i64
    %2 = llvm.ashr %1, %c5_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %1, %c_44_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %0 = llvm.trunc %true : i1 to i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.icmp "sle" %c34_i64, %c30_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.and %c48_i64, %arg0 : i64
    %1 = llvm.select %arg1, %arg2, %c2_i64 : i1, i64
    %2 = llvm.and %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.icmp "sge" %c_17_i64, %c49_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ule" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.sdiv %c32_i64, %0 : i64
    %2 = llvm.icmp "sle" %1, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c27_i64 = arith.constant 27 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %c18_i64, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %1, %c27_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_16_i64 = arith.constant -16 : i64
    %0 = llvm.udiv %c_16_i64, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c26_i64 = arith.constant 26 : i64
    %c46_i64 = arith.constant 46 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.select %arg0, %c46_i64, %c_43_i64 : i1, i64
    %1 = llvm.icmp "ne" %c26_i64, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.icmp "sgt" %arg0, %c38_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %1, %c44_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c_2_i64, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.icmp "sge" %arg0, %c25_i64 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.icmp "ugt" %1, %c_30_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %c_43_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %c2_i64, %0 : i64
    %2 = llvm.icmp "ugt" %c11_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "slt" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.icmp "ult" %c7_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sge" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %c16_i64 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.select %arg2, %c30_i64, %arg0 : i1, i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg2 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c3_i64 = arith.constant 3 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "eq" %c34_i64, %c_6_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sle" %1, %c3_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.select %0, %1, %c22_i64 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %c_32_i64, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c7_i64 = arith.constant 7 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sle" %c_6_i64, %c34_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.xor %1, %c7_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %arg1, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.select %false, %arg0, %c_47_i64 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c_5_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.ashr %c_44_i64, %arg0 : i64
    %1 = llvm.urem %c_16_i64, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.sdiv %c14_i64, %arg0 : i64
    %1 = llvm.or %arg1, %c_36_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.urem %c_40_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c46_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sgt" %c_7_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "ult" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.trunc %false : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.icmp "ne" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c7_i64 = arith.constant 7 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "eq" %c7_i64, %c_41_i64 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %c45_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.urem %arg1, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %c19_i64 = arith.constant 19 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %c19_i64, %c33_i64 : i64
    %1 = llvm.icmp "sgt" %c_45_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.lshr %arg1, %c7_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %1, %c_2_i64 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %c_34_i64 = arith.constant -34 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.ashr %c_34_i64, %c31_i64 : i64
    %1 = llvm.sdiv %c37_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %c2_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c_29_i64, %0 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %c_13_i64, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "uge" %1, %c_47_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
    %c11_i64 = arith.constant 11 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c45_i64 = arith.constant 45 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %c45_i64, %c4_i64 : i64
    %1 = llvm.urem %0, %c11_i64 : i64
    %2 = llvm.udiv %c_25_i64, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "ult" %c44_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_45_i64 = arith.constant -45 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %c_45_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg2 : i64
    %1 = llvm.select %arg1, %arg0, %0 : i1, i64
    %2 = llvm.udiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c14_i64 = arith.constant 14 : i64
    %c_4_i64 = arith.constant -4 : i64
    %0 = llvm.and %arg0, %c_4_i64 : i64
    %1 = llvm.xor %arg0, %c14_i64 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.urem %c_28_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.icmp "sge" %1, %arg0 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.sdiv %c_13_i64, %0 : i64
    %2 = llvm.icmp "ult" %1, %arg1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.or %c34_i64, %arg0 : i64
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.ashr %arg0, %c10_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.icmp "ne" %1, %c43_i64 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %c0_i64, %c_49_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_26_i64 = arith.constant -26 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.ashr %c_26_i64, %c44_i64 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i1 to i64
    %2 = llvm.icmp "sle" %c_20_i64, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
    %c_30_i64 = arith.constant -30 : i64
    %c22_i64 = arith.constant 22 : i64
    %c0_i64 = arith.constant 0 : i64
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.udiv %c0_i64, %c18_i64 : i64
    %1 = llvm.udiv %c22_i64, %c_30_i64 : i64
    %2 = llvm.icmp "sle" %0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.icmp "slt" %arg0, %c_2_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %arg0 : i1 to i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.trunc %arg0 : i1 to i64
    %1 = llvm.icmp "ult" %0, %c46_i64 : i64
    %2 = llvm.trunc %1 : i1 to i64
    return %2 : i64
  }
}
// -----
