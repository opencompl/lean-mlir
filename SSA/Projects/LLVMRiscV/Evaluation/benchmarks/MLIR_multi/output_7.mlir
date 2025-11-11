module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c_37_i64 = arith.constant -37 : i64
    %c_25_i64 = arith.constant -25 : i64
    %c_38_i32 = arith.constant -38 : i32
    %0 = llvm.sext %c_38_i32 : i32 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.select %1, %2, %c_25_i64 : i1, i64
    %4 = llvm.urem %c_37_i64, %arg0 : i64
    %5 = llvm.select %arg2, %arg1, %4 : i1, i64
    %6 = llvm.lshr %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.ashr %c2_i64, %arg1 : i64
    %2 = llvm.srem %arg1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "ugt" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.or %arg0, %c27_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.ashr %1, %arg1 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_31_i64 = arith.constant -31 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.or %1, %c_31_i64 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.udiv %arg0, %3 : i64
    %5 = llvm.urem %c37_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_17_i64 = arith.constant -17 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.trunc %c_6_i64 : i64 to i1
    %1 = llvm.select %0, %arg0, %c_17_i64 : i1, i64
    %2 = llvm.trunc %arg0 : i64 to i1
    %3 = llvm.srem %arg1, %arg0 : i64
    %4 = llvm.select %2, %3, %arg1 : i1, i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c4_i64 = arith.constant 4 : i64
    %c_50_i64 = arith.constant -50 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c_36_i64, %c_39_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.urem %c_50_i64, %1 : i64
    %4 = llvm.srem %0, %c4_i64 : i64
    %5 = llvm.select %arg1, %3, %4 : i1, i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.ashr %c40_i64, %arg0 : i64
    %5 = llvm.select %3, %4, %4 : i1, i64
    %6 = llvm.icmp "ule" %5, %arg0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c_3_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c_9_i64 : i64
    %2 = llvm.xor %1, %c_23_i64 : i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %5, %0 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_44_i64 = arith.constant -44 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %arg0, %c31_i64 : i64
    %1 = llvm.and %c_44_i64, %0 : i64
    %2 = llvm.trunc %arg0 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "uge" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "sgt" %5, %arg1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_50_i64 = arith.constant -50 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %c_41_i64, %c_50_i64 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_37_i32 = arith.constant -37 : i32
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "slt" %arg0, %c_38_i64 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.sext %c_37_i32 : i32 to i64
    %3 = llvm.lshr %2, %arg2 : i64
    %4 = llvm.sext %false : i1 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.udiv %1, %c26_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c21_i64 = arith.constant 21 : i64
    %c28_i64 = arith.constant 28 : i64
    %c_49_i64 = arith.constant -49 : i64
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c_49_i64, %c_43_i64 : i64
    %1 = llvm.srem %0, %c28_i64 : i64
    %2 = llvm.srem %1, %0 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.and %4, %c21_i64 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_18_i64 = arith.constant -18 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %0 : i64
    %2 = llvm.ashr %c27_i64, %c_18_i64 : i64
    %3 = llvm.icmp "ule" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i64 {
    %c35_i64 = arith.constant 35 : i64
    %true = arith.constant true
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %c27_i64, %arg0 : i64
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.select %true, %1, %arg2 : i1, i64
    %3 = llvm.trunc %0 : i64 to i1
    %4 = llvm.select %3, %c35_i64, %0 : i1, i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.xor %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.urem %4, %0 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c_29_i64, %c48_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.xor %2, %c_23_i64 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %c_40_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.or %c17_i64, %1 : i64
    %3 = llvm.sdiv %1, %arg0 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.and %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.and %arg0, %c12_i64 : i64
    %1 = llvm.or %c50_i64, %0 : i64
    %2 = llvm.trunc %arg0 : i64 to i1
    %3 = llvm.select %2, %1, %arg0 : i1, i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.zext %2 : i1 to i64
    %6 = llvm.srem %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %c_19_i64, %1 : i1, i64
    %3 = llvm.or %c6_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_50_i64 = arith.constant -50 : i64
    %c34_i64 = arith.constant 34 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %c34_i64, %c22_i64 : i64
    %1 = llvm.xor %0, %c_50_i64 : i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.and %arg0, %arg0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c38_i64 = arith.constant 38 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %c38_i64, %c_34_i64 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.urem %4, %4 : i64
    %6 = llvm.icmp "sle" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_49_i64 = arith.constant -49 : i64
    %c_32_i64 = arith.constant -32 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c_39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %c_39_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.sdiv %1, %c_7_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ne" %c_32_i64, %c_49_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.srem %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.lshr %1, %c41_i64 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.ashr %3, %3 : i64
    %5 = llvm.and %4, %arg2 : i64
    %6 = llvm.or %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_47_i64 = arith.constant -47 : i64
    %c35_i64 = arith.constant 35 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c_20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c_7_i64, %c_20_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.lshr %1, %c35_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c_47_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c_25_i64 = arith.constant -25 : i64
    %c_26_i64 = arith.constant -26 : i64
    %c_35_i64 = arith.constant -35 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.lshr %c_6_i64, %c_36_i64 : i64
    %2 = llvm.srem %arg2, %c_35_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sdiv %c_26_i64, %c_25_i64 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c48_i64 = arith.constant 48 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %arg0, %arg1, %c_41_i64 : i1, i64
    %3 = llvm.and %c48_i64, %2 : i64
    %4 = llvm.xor %c_44_i64, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.select %arg0, %c_17_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %c_23_i64, %1 : i64
    %3 = llvm.icmp "ugt" %c15_i64, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.udiv %4, %c15_i64 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c17_i64 = arith.constant 17 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.trunc %c24_i64 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c17_i64, %1 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.or %arg0, %1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_17_i64 = arith.constant -17 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %c23_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.srem %c_17_i64, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %0 = llvm.trunc %c8_i64 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.select %2, %4, %1 : i1, i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %c_19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %true, %0, %c_19_i64 : i1, i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sext %arg0 : i32 to i64
    %6 = llvm.icmp "eq" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.ashr %c9_i64, %arg1 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.or %c5_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.select %arg1, %arg2, %c_14_i64 : i1, i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.udiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg2, %0 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.sdiv %0, %0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i1 {
    %c_37_i64 = arith.constant -37 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %arg2, %c_25_i64 : i64
    %3 = llvm.srem %arg0, %c_37_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "ugt" %5, %1 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %false = arith.constant false
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.select %false, %c17_i64, %arg0 : i1, i64
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %false = arith.constant false
    %c_20_i64 = arith.constant -20 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %c_20_i64, %c10_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %arg2, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.and %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c3_i64 = arith.constant 3 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.or %arg2, %c42_i64 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.and %c3_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c_9_i64 = arith.constant -9 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %c_44_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %arg0 : i64
    %2 = llvm.xor %arg0, %c7_i64 : i64
    %3 = llvm.srem %c_9_i64, %2 : i64
    %4 = llvm.select %1, %arg0, %3 : i1, i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c14_i64 : i64
    %2 = llvm.xor %1, %c23_i64 : i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.select %true, %arg0, %c23_i64 : i1, i64
    %2 = llvm.urem %arg1, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_12_i64 = arith.constant -12 : i64
    %c_1_i64 = arith.constant -1 : i64
    %0 = llvm.ashr %c_1_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.xor %arg2, %c_12_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c47_i64 = arith.constant 47 : i64
    %c_16_i64 = arith.constant -16 : i64
    %c_22_i64 = arith.constant -22 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %arg0, %c41_i64 : i64
    %1 = llvm.xor %c47_i64, %c7_i64 : i64
    %2 = llvm.udiv %c_16_i64, %1 : i64
    %3 = llvm.urem %c_22_i64, %2 : i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.xor %1, %0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.select %arg1, %0, %3 : i1, i64
    %5 = llvm.ashr %4, %4 : i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c_9_i64 = arith.constant -9 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %arg0, %c21_i64 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.srem %3, %c_9_i64 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i1 {
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.or %c_6_i64, %arg1 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.and %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c21_i64 = arith.constant 21 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.srem %c21_i64, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sdiv %c4_i64, %4 : i64
    %6 = llvm.urem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_7_i64 = arith.constant -7 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c_7_i64, %c49_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.lshr %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.xor %c50_i64, %arg0 : i64
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.and %arg2, %c13_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.lshr %0, %arg1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.trunc %c14_i64 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.xor %c_8_i64, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %c_49_i64, %arg1 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.select %arg0, %c45_i64, %arg2 : i1, i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.sdiv %1, %arg2 : i64
    %5 = llvm.ashr %arg1, %4 : i64
    %6 = llvm.icmp "sgt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_16_i64 = arith.constant -16 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ugt" %arg0, %c29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i64 to i1
    %3 = llvm.select %2, %arg2, %c_16_i64 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_21_i64 = arith.constant -21 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c12_i64, %c_21_i64 : i64
    %5 = llvm.select %4, %1, %1 : i1, i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c_3_i64 = arith.constant -3 : i64
    %c14_i64 = arith.constant 14 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %arg0, %c_40_i64 : i64
    %1 = llvm.lshr %0, %c14_i64 : i64
    %2 = llvm.xor %c_3_i64, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.select %arg1, %arg2, %2 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_40_i64 = arith.constant -40 : i64
    %c2_i64 = arith.constant 2 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %c_42_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c2_i64, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.and %4, %c_40_i64 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %c_30_i64, %0 : i64
    %3 = llvm.urem %arg1, %arg0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.udiv %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %c34_i64 = arith.constant 34 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c_13_i64, %c34_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %c24_i64, %arg1 : i1, i64
    %4 = llvm.icmp "eq" %0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.icmp "sge" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c27_i64 = arith.constant 27 : i64
    %c_18_i64 = arith.constant -18 : i64
    %0 = llvm.and %c_18_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.urem %1, %c27_i64 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %4, %0 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c9_i64 = arith.constant 9 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %c38_i64 : i64
    %2 = llvm.sdiv %arg0, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.srem %c9_i64, %arg1 : i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %c_22_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %c_34_i64, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    %4 = llvm.sext %arg1 : i1 to i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.urem %arg2, %arg1 : i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.select %arg0, %1, %arg1 : i1, i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.ashr %c36_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.or %arg2, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.sdiv %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %1, %arg1 : i64
    %3 = llvm.icmp "sgt" %2, %arg1 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.or %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_10_i64 = arith.constant -10 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %arg0, %c_44_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %1, %c_10_i64 : i64
    %3 = llvm.udiv %arg1, %arg2 : i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.urem %1, %4 : i64
    %6 = llvm.sdiv %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64, %arg2: i1) -> i1 {
    %c_35_i64 = arith.constant -35 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.ashr %c4_i64, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.ashr %c_35_i64, %3 : i64
    %5 = llvm.ashr %4, %0 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.select %false, %arg0, %c43_i64 : i1, i64
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.ashr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c6_i64 = arith.constant 6 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.sdiv %c29_i64, %arg0 : i64
    %1 = llvm.lshr %0, %c6_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.urem %3, %arg1 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.ashr %5, %1 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_44_i64 = arith.constant -44 : i64
    %c_35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %arg0, %c_35_i64 : i64
    %1 = llvm.and %c_44_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.lshr %4, %arg1 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.trunc %c33_i64 : i64 to i1
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c23_i64 = arith.constant 23 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.urem %0, %c23_i64 : i64
    %2 = llvm.lshr %arg0, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_39_i64 = arith.constant -39 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %c_46_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %c_39_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_1_i64 = arith.constant -1 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.srem %c26_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %c_1_i64 : i1, i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.sdiv %c_10_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %arg0, %c_24_i64 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.or %3, %arg2 : i64
    %5 = llvm.ashr %4, %3 : i64
    %6 = llvm.icmp "ne" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %false = arith.constant false
    %c_8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c_8_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.xor %arg2, %arg0 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %c37_i64 = arith.constant 37 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %c_41_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %arg1, %c_10_i64 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.urem %3, %arg2 : i64
    %5 = llvm.srem %c37_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_43_i64 = arith.constant -43 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %arg0, %c30_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.and %c_43_i64, %arg0 : i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c_25_i64 = arith.constant -25 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.trunc %arg2 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %c21_i64 : i64 to i1
    %3 = llvm.sdiv %arg1, %c_25_i64 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.select %arg0, %arg1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i32 {
    %c_14_i64 = arith.constant -14 : i64
    %c_46_i64 = arith.constant -46 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "uge" %c_46_i64, %c14_i64 : i64
    %1 = llvm.select %0, %c_14_i64, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.sext %arg1 : i32 to i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_15_i64 = arith.constant -15 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %c48_i64 : i64 to i1
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.xor %c_15_i64, %1 : i64
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.ashr %arg0, %c2_i64 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.icmp "ugt" %0, %1 : i64
    %3 = llvm.select %2, %arg2, %0 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    %2 = llvm.or %0, %arg0 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.select %1, %0, %3 : i1, i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %c6_i64 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.or %4, %arg2 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_7_i64 = arith.constant -7 : i64
    %c42_i64 = arith.constant 42 : i64
    %c8_i32 = arith.constant 8 : i32
    %0 = llvm.sext %c8_i32 : i32 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %c42_i64 : i64
    %3 = llvm.sdiv %c_7_i64, %arg1 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c_38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %c_38_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.ashr %3, %arg2 : i64
    %5 = llvm.select %false, %0, %4 : i1, i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_4_i64 = arith.constant -4 : i64
    %c26_i64 = arith.constant 26 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %c42_i64 : i64 to i1
    %1 = llvm.xor %c_4_i64, %arg0 : i64
    %2 = llvm.udiv %c26_i64, %1 : i64
    %3 = llvm.or %arg0, %arg2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.select %0, %2, %4 : i1, i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %1, %c_48_i64 : i64
    %3 = llvm.xor %2, %1 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c_5_i64, %arg0 : i64
    %3 = llvm.urem %2, %1 : i64
    %4 = llvm.and %3, %1 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i1) -> i64 {
    %c_2_i64 = arith.constant -2 : i64
    %c_46_i64 = arith.constant -46 : i64
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.srem %c_46_i64, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.select %5, %2, %c_2_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c8_i64 = arith.constant 8 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.and %arg0, %c23_i64 : i64
    %1 = llvm.sdiv %arg2, %arg2 : i64
    %2 = llvm.and %1, %c8_i64 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c_27_i32 = arith.constant -27 : i32
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg0, %c46_i64, %arg1 : i1, i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.sext %c_27_i32 : i32 to i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.or %2, %3 : i64
    %5 = llvm.icmp "uge" %1, %4 : i64
    %6 = llvm.zext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.trunc %c10_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.udiv %1, %2 : i64
    %4 = llvm.srem %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.zext %5 : i32 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %c_25_i64, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg0, %c_24_i64 : i64
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
