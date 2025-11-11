module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.ashr %c5_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.udiv %arg0, %c_38_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.icmp "uge" %3, %c41_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %false = arith.constant false
    %c_42_i64 = arith.constant -42 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.srem %c_42_i64, %c_32_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %c39_i64 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c22_i64 = arith.constant 22 : i64
    %c_12_i64 = arith.constant -12 : i64
    %0 = llvm.select %arg2, %c22_i64, %c_12_i64 : i1, i64
    %1 = llvm.udiv %c13_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.srem %arg1, %2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64, %arg2: i1) -> i64 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.select %arg2, %0, %arg1 : i1, i64
    %2 = llvm.sdiv %1, %c43_i64 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %false = arith.constant false
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.and %c1_i64, %1 : i64
    %3 = llvm.select %false, %2, %arg1 : i1, i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.icmp "eq" %arg0, %2 : i64
    %4 = llvm.zext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_48_i64 = arith.constant -48 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.udiv %c46_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.select %1, %arg0, %2 : i1, i64
    %4 = llvm.icmp "ugt" %c_48_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.sdiv %arg1, %0 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.lshr %c16_i64, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c19_i64 = arith.constant 19 : i64
    %c_38_i64 = arith.constant -38 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.and %1, %c_38_i64 : i64
    %3 = llvm.srem %2, %c19_i64 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.and %c50_i64, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %c25_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.srem %arg0, %c32_i64 : i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.select %1, %2, %arg2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_36_i64 = arith.constant -36 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %arg0, %c_6_i64 : i64
    %1 = llvm.urem %arg0, %c_36_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.icmp "sge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c17_i64 = arith.constant 17 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.xor %c_6_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.icmp "ne" %c17_i64, %1 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i64
    %4 = llvm.sdiv %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c_33_i64 = arith.constant -33 : i64
    %c_42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c_33_i64, %c_42_i64 : i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.icmp "sgt" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.ashr %arg0, %c35_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %c_44_i64, %2 : i64
    %4 = llvm.srem %3, %2 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.urem %c_34_i64, %c13_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.select %3, %2, %arg0 : i1, i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.srem %c34_i64, %c34_i64 : i64
    %4 = llvm.icmp "ne" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_31_i64 = arith.constant -31 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.and %c_31_i64, %2 : i64
    %4 = llvm.and %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c47_i64 = arith.constant 47 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.lshr %c47_i64, %c_48_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.icmp "uge" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %false = arith.constant false
    %c13_i64 = arith.constant 13 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %c13_i64, %0 : i64
    %2 = llvm.sext %false : i1 to i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %c5_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_5_i64 = arith.constant -5 : i64
    %c_32_i64 = arith.constant -32 : i64
    %0 = llvm.sdiv %arg0, %c_32_i64 : i64
    %1 = llvm.sdiv %arg1, %arg2 : i64
    %2 = llvm.icmp "slt" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "sle" %c_5_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.xor %arg1, %arg0 : i64
    %2 = llvm.lshr %1, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c_47_i64 = arith.constant -47 : i64
    %c_45_i64 = arith.constant -45 : i64
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.urem %c_45_i64, %c_31_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.or %1, %c_47_i64 : i64
    %3 = llvm.or %2, %c1_i64 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg1, %c_25_i64 : i1, i64
    %2 = llvm.ashr %1, %arg2 : i64
    %3 = llvm.or %2, %c50_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.and %2, %2 : i64
    %4 = llvm.ashr %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_34_i64 = arith.constant -34 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.trunc %c2_i64 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %1, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.xor %c_34_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %c_43_i64 = arith.constant -43 : i64
    %0 = llvm.select %arg1, %c_43_i64, %arg0 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %arg2 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.srem %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %true = arith.constant true
    %c_2_i64 = arith.constant -2 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.select %true, %c_2_i64, %1 : i1, i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_34_i64 = arith.constant -34 : i64
    %c_6_i64 = arith.constant -6 : i64
    %c_12_i64 = arith.constant -12 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.urem %c_12_i64, %c_25_i64 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.select %2, %0, %c_34_i64 : i1, i64
    %4 = llvm.icmp "ugt" %c_6_i64, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c_31_i64 = arith.constant -31 : i64
    %0 = llvm.select %arg1, %c_31_i64, %arg2 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c40_i64 = arith.constant 40 : i64
    %true = arith.constant true
    %c_29_i64 = arith.constant -29 : i64
    %0 = llvm.select %true, %arg0, %c_29_i64 : i1, i64
    %1 = llvm.lshr %0, %c40_i64 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.ashr %2, %arg1 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_27_i64 = arith.constant -27 : i64
    %c0_i64 = arith.constant 0 : i64
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.icmp "eq" %c11_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sge" %c0_i64, %c_27_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %2, %c37_i64 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %c_48_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_10_i64 = arith.constant -10 : i64
    %0 = llvm.and %c_10_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.xor %2, %arg1 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.ashr %arg2, %c18_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_32_i64 = arith.constant -32 : i64
    %c_34_i64 = arith.constant -34 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %c_34_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.ashr %arg2, %c_32_i64 : i64
    %4 = llvm.icmp "sle" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c_27_i64 = arith.constant -27 : i64
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.lshr %c_27_i64, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %true = arith.constant true
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.trunc %c45_i64 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c40_i64 = arith.constant 40 : i64
    %c0_i64 = arith.constant 0 : i64
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.lshr %c0_i64, %c_13_i64 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.or %0, %c40_i64 : i64
    %4 = llvm.srem %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %arg0, %arg0 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.icmp "eq" %1, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_13_i64 = arith.constant -13 : i64
    %0 = llvm.sdiv %arg0, %c_13_i64 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c_17_i64 = arith.constant -17 : i64
    %0 = llvm.or %c_17_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg2 : i64
    %2 = llvm.urem %1, %c35_i64 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "uge" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_15_i64 = arith.constant -15 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.and %arg0, %c6_i64 : i64
    %1 = llvm.lshr %arg0, %c_15_i64 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.udiv %1, %0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c_4_i64 = arith.constant -4 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %arg0, %c_44_i64 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %c_4_i64, %1 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %c_29_i64, %c_25_i64 : i64
    %1 = llvm.ashr %c_41_i64, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.xor %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c_28_i64 = arith.constant -28 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg1, %c_28_i64 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.lshr %arg0, %c24_i64 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c44_i64 = arith.constant 44 : i64
    %c45_i64 = arith.constant 45 : i64
    %c_29_i64 = arith.constant -29 : i64
    %c_26_i64 = arith.constant -26 : i64
    %0 = llvm.udiv %arg0, %c_26_i64 : i64
    %1 = llvm.xor %c_29_i64, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sdiv %2, %c45_i64 : i64
    %4 = llvm.icmp "sle" %3, %c44_i64 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_23_i64 = arith.constant -23 : i64
    %0 = llvm.trunc %c_23_i64 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.udiv %1, %arg0 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %c17_i64, %2 : i64
    %4 = llvm.icmp "slt" %3, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c_1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %c_47_i64 = arith.constant -47 : i64
    %0 = llvm.srem %c_47_i64, %arg0 : i64
    %1 = llvm.and %c_1_i64, %0 : i64
    %2 = llvm.select %false, %1, %0 : i1, i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.urem %arg1, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %arg2, %c6_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.select %1, %0, %0 : i1, i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c_7_i64 = arith.constant -7 : i64
    %c_42_i64 = arith.constant -42 : i64
    %c_9_i64 = arith.constant -9 : i64
    %0 = llvm.sdiv %arg0, %c_9_i64 : i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.xor %c_42_i64, %1 : i64
    %3 = llvm.and %c_7_i64, %2 : i64
    %4 = llvm.lshr %c15_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.and %0, %arg2 : i64
    %4 = llvm.xor %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.select %false, %arg1, %arg2 : i1, i64
    %4 = llvm.icmp "ugt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c_8_i64 = arith.constant -8 : i64
    %c_41_i64 = arith.constant -41 : i64
    %0 = llvm.udiv %c_41_i64, %arg0 : i64
    %1 = llvm.udiv %c_8_i64, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %arg0, %arg2 : i64
    %4 = llvm.icmp "sgt" %2, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.and %0, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.ashr %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.or %arg2, %c_44_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.select %0, %1, %2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %c36_i64, %arg0 : i64
    %1 = llvm.trunc %arg0 : i64 to i1
    %2 = llvm.select %1, %0, %arg2 : i1, i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c25_i64 = arith.constant 25 : i64
    %c_40_i64 = arith.constant -40 : i64
    %0 = llvm.udiv %c_40_i64, %arg0 : i64
    %1 = llvm.trunc %c25_i64 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_14_i64 = arith.constant -14 : i64
    %c3_i64 = arith.constant 3 : i64
    %c_49_i64 = arith.constant -49 : i64
    %0 = llvm.and %c3_i64, %c_49_i64 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.lshr %arg0, %c_14_i64 : i64
    %3 = llvm.lshr %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.sdiv %c41_i64, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_46_i64 = arith.constant -46 : i64
    %c_36_i64 = arith.constant -36 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.udiv %c5_i64, %arg0 : i64
    %1 = llvm.and %c_36_i64, %c_46_i64 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %c30_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.and %arg1, %c_44_i64 : i64
    %1 = llvm.udiv %0, %c11_i64 : i64
    %2 = llvm.icmp "ne" %1, %arg2 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.icmp "slt" %arg0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_7_i64 = arith.constant -7 : i64
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %c_7_i64 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.ashr %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c5_i64 = arith.constant 5 : i64
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.icmp "ne" %arg0, %c39_i64 : i64
    %1 = llvm.select %0, %c5_i64, %arg1 : i1, i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c_19_i64 = arith.constant -19 : i64
    %c_48_i64 = arith.constant -48 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.and %c_48_i64, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.xor %c_19_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.ashr %0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i64
    %4 = llvm.or %1, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c_41_i64 = arith.constant -41 : i64
    %c_24_i64 = arith.constant -24 : i64
    %0 = llvm.ashr %c_41_i64, %c_24_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_33_i64 = arith.constant -33 : i64
    %c_2_i64 = arith.constant -2 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c_2_i64 : i64
    %2 = llvm.lshr %arg0, %c_33_i64 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.xor %c0_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg2, %arg0 : i64
    %2 = llvm.lshr %arg1, %1 : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.icmp "ule" %0, %3 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.xor %c24_i64, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c22_i64 = arith.constant 22 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.ashr %arg1, %arg2 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.select %0, %2, %c22_i64 : i1, i64
    %4 = llvm.ashr %c27_i64, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c_35_i64 = arith.constant -35 : i64
    %c_6_i64 = arith.constant -6 : i64
    %0 = llvm.lshr %c_6_i64, %arg0 : i64
    %1 = llvm.icmp "ne" %c_35_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %2, %2 : i64
    %4 = llvm.sdiv %arg0, %3 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c_44_i64 = arith.constant -44 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %c_44_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    return %4 : i32
  }
}
// -----
