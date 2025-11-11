module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %0 = llvm.urem %c-33_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.sdiv %3, %arg1 : i64
    %5 = llvm.and %arg0, %4 : i64
    %6 = llvm.udiv %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c30_i64 = arith.constant 30 : i64
    %c47_i64 = arith.constant 47 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.and %arg0, %c6_i64 : i64
    %1 = llvm.sdiv %0, %c47_i64 : i64
    %2 = llvm.and %c30_i64, %arg0 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.urem %arg1, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.icmp "ule" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.select %arg2, %c43_i64, %c10_i64 : i1, i64
    %5 = llvm.or %4, %0 : i64
    %6 = llvm.icmp "slt" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    %2 = llvm.udiv %1, %c-26_i64 : i64
    %3 = llvm.or %1, %2 : i64
    %4 = llvm.udiv %0, %arg1 : i64
    %5 = llvm.or %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c26_i64 = arith.constant 26 : i64
    %c14_i32 = arith.constant 14 : i32
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %c14_i32 : i32 to i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.udiv %c26_i64, %3 : i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.or %arg0, %c20_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %arg0, %c20_i64 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.udiv %arg1, %0 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.sdiv %5, %c-50_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.lshr %c-2_i64, %1 : i64
    %3 = llvm.srem %2, %1 : i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.icmp "slt" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-39_i64 = arith.constant -39 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %c-39_i64, %1 : i64
    %3 = llvm.select %0, %2, %arg0 : i1, i64
    %4 = llvm.and %3, %3 : i64
    %5 = llvm.urem %c27_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-21_i64 = arith.constant -21 : i64
    %false = arith.constant false
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.udiv %c39_i64, %1 : i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.select %false, %arg1, %c-21_i64 : i1, i64
    %5 = llvm.lshr %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ult" %0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.ashr %c-32_i64, %c-3_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.icmp "sge" %1, %arg1 : i64
    %3 = llvm.select %2, %1, %c18_i64 : i1, i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %false = arith.constant false
    %c41_i64 = arith.constant 41 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.udiv %c41_i64, %c-9_i64 : i64
    %1 = llvm.or %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.select %false, %arg2, %arg0 : i1, i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.udiv %arg2, %1 : i64
    %6 = llvm.icmp "sle" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c15_i64 = arith.constant 15 : i64
    %c39_i64 = arith.constant 39 : i64
    %c19_i64 = arith.constant 19 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c5_i64 = arith.constant 5 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.ashr %arg0, %c38_i64 : i64
    %1 = llvm.srem %0, %c-1_i64 : i64
    %2 = llvm.lshr %c19_i64, %c39_i64 : i64
    %3 = llvm.xor %c48_i64, %2 : i64
    %4 = llvm.urem %3, %c15_i64 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.udiv %c5_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.srem %arg0, %c50_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.ashr %2, %0 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.zext %arg1 : i32 to i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.select %arg0, %c37_i64, %arg1 : i1, i64
    %1 = llvm.and %0, %arg2 : i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.and %2, %arg1 : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64, %arg2: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.sdiv %arg1, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.srem %c34_i64, %arg2 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.xor %c-17_i64, %0 : i64
    %6 = llvm.or %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.trunc %c-50_i64 : i64 to i1
    %1 = llvm.and %arg0, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.select %0, %arg0, %2 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.icmp "slt" %5, %arg2 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.icmp "sge" %arg2, %c-46_i64 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %c15_i64, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.xor %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.lshr %c-42_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %c-22_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.or %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.trunc %c32_i64 : i64 to i1
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.trunc %c-29_i64 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sdiv %arg1, %arg0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.select %0, %4, %2 : i1, i64
    %6 = llvm.sdiv %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c4_i64 = arith.constant 4 : i64
    %c-49_i64 = arith.constant -49 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.icmp "eq" %c-12_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.zext %arg1 : i1 to i64
    %3 = llvm.xor %1, %2 : i64
    %4 = llvm.and %c-49_i64, %c4_i64 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i32) -> i64 {
    %c-44_i64 = arith.constant -44 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.sext %arg2 : i32 to i64
    %2 = llvm.and %c-44_i64, %1 : i64
    %3 = llvm.lshr %c-42_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.udiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %true = arith.constant true
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "sge" %0, %c18_i64 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.select %true, %c-11_i64, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.select %0, %1, %arg2 : i1, i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i64
    %5 = llvm.select %3, %c42_i64, %4 : i1, i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %true = arith.constant true
    %c-3_i64 = arith.constant -3 : i64
    %c-4_i64 = arith.constant -4 : i64
    %0 = llvm.select %true, %c-3_i64, %c-4_i64 : i1, i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.srem %arg1, %0 : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.icmp "slt" %5, %3 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32, %arg2: i64) -> i32 {
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %arg0, %0 : i64
    %3 = llvm.or %arg2, %2 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-36_i64 = arith.constant -36 : i64
    %c37_i64 = arith.constant 37 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %c16_i64, %0 : i64
    %2 = llvm.select %arg0, %c37_i64, %1 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.udiv %4, %arg1 : i64
    %6 = llvm.srem %c-36_i64, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-14_i64 = arith.constant -14 : i64
    %c50_i64 = arith.constant 50 : i64
    %c-12_i64 = arith.constant -12 : i64
    %true = arith.constant true
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.select %true, %0, %arg2 : i1, i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.xor %c50_i64, %c-14_i64 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %c-12_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.ashr %c-37_i64, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.srem %2, %arg1 : i64
    %4 = llvm.and %3, %arg0 : i64
    %5 = llvm.or %4, %arg0 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %true = arith.constant true
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.select %true, %arg0, %1 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c43_i64 = arith.constant 43 : i64
    %0 = llvm.udiv %arg1, %c43_i64 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.udiv %2, %arg2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.icmp "ugt" %c27_i64, %arg0 : i64
    %1 = llvm.or %c-22_i64, %arg0 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    %4 = llvm.urem %arg0, %2 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.urem %5, %arg2 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %c-43_i64 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.or %4, %arg2 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-38_i64 = arith.constant -38 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.lshr %arg0, %c44_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.and %arg1, %arg2 : i64
    %3 = llvm.ashr %c-38_i64, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.udiv %arg0, %arg0 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.trunc %0 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    %2 = llvm.xor %c-11_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %c-45_i64 : i1, i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.xor %arg2, %arg2 : i64
    %3 = llvm.lshr %arg0, %c-18_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.or %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c9_i64 = arith.constant 9 : i64
    %true = arith.constant true
    %c-1_i64 = arith.constant -1 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %arg0, %c-25_i64 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.or %c-1_i64, %1 : i64
    %3 = llvm.udiv %1, %c9_i64 : i64
    %4 = llvm.select %true, %3, %arg1 : i1, i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %c-9_i64, %0 : i64
    %2 = llvm.lshr %c35_i64, %0 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.xor %arg1, %3 : i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %0 = llvm.icmp "ult" %arg0, %c19_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.and %4, %arg0 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c1_i64 = arith.constant 1 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.icmp "sgt" %1, %0 : i64
    %3 = llvm.srem %c38_i64, %0 : i64
    %4 = llvm.select %2, %3, %c1_i64 : i1, i64
    %5 = llvm.udiv %4, %3 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c1_i64 = arith.constant 1 : i64
    %c5_i64 = arith.constant 5 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.srem %c-39_i64, %arg0 : i64
    %1 = llvm.srem %c5_i64, %0 : i64
    %2 = llvm.trunc %arg1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.or %c1_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.sdiv %arg0, %c6_i64 : i64
    %1 = llvm.sdiv %c-1_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.udiv %3, %3 : i64
    %5 = llvm.and %4, %4 : i64
    %6 = llvm.icmp "sge" %5, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-3_i64 = arith.constant -3 : i64
    %c6_i32 = arith.constant 6 : i32
    %c6_i64 = arith.constant 6 : i64
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.udiv %c16_i64, %arg0 : i64
    %1 = llvm.sext %c6_i32 : i32 to i64
    %2 = llvm.urem %c6_i64, %1 : i64
    %3 = llvm.xor %0, %2 : i64
    %4 = llvm.xor %c-3_i64, %arg1 : i64
    %5 = llvm.and %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %false = arith.constant false
    %c4_i64 = arith.constant 4 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.trunc %c-2_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.sext %false : i1 to i64
    %4 = llvm.udiv %c4_i64, %3 : i64
    %5 = llvm.srem %4, %arg0 : i64
    %6 = llvm.urem %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c-14_i64 = arith.constant -14 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "ne" %c26_i64, %arg0 : i64
    %1 = llvm.icmp "sle" %c-27_i64, %arg0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.select %0, %2, %c-45_i64 : i1, i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.sdiv %c-14_i64, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.or %c14_i64, %1 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.select %arg1, %0, %arg2 : i1, i64
    %5 = llvm.ashr %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %c2_i64 = arith.constant 2 : i64
    %true = arith.constant true
    %c16_i64 = arith.constant 16 : i64
    %0 = llvm.lshr %arg0, %c16_i64 : i64
    %1 = llvm.select %true, %c2_i64, %c17_i64 : i1, i64
    %2 = llvm.ashr %arg2, %1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.select %arg0, %c-40_i64, %1 : i1, i64
    %3 = llvm.sdiv %2, %1 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %c22_i64 = arith.constant 22 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.srem %c22_i64, %c-25_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.lshr %2, %2 : i64
    %4 = llvm.and %3, %c30_i64 : i64
    %5 = llvm.sdiv %4, %3 : i64
    %6 = llvm.sdiv %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %true = arith.constant true
    %c47_i64 = arith.constant 47 : i64
    %0 = llvm.select %true, %arg0, %c47_i64 : i1, i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.or %arg1, %3 : i64
    %5 = llvm.urem %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-18_i64 = arith.constant -18 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.ashr %c-41_i64, %arg0 : i64
    %1 = llvm.lshr %c-18_i64, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.or %0, %2 : i64
    %4 = llvm.trunc %2 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.or %3, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.sdiv %c-8_i64, %1 : i64
    %3 = llvm.ashr %arg0, %2 : i64
    %4 = llvm.xor %2, %2 : i64
    %5 = llvm.urem %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.zext %0 : i1 to i64
    %5 = llvm.xor %3, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c5_i64 = arith.constant 5 : i64
    %true = arith.constant true
    %c-13_i64 = arith.constant -13 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.select %true, %c-13_i64, %c14_i64 : i1, i64
    %1 = llvm.urem %0, %c5_i64 : i64
    %2 = llvm.select %arg1, %0, %1 : i1, i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.and %3, %arg2 : i64
    %5 = llvm.srem %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.srem %c23_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.xor %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.srem %2, %c35_i64 : i64
    %4 = llvm.icmp "ult" %1, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c35_i64 = arith.constant 35 : i64
    %0 = llvm.or %c35_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %c46_i64 = arith.constant 46 : i64
    %c32_i64 = arith.constant 32 : i64
    %c-2_i64 = arith.constant -2 : i64
    %0 = llvm.sdiv %c32_i64, %c-2_i64 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %4 = llvm.lshr %3, %c46_i64 : i64
    %5 = llvm.sdiv %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i32) -> i1 {
    %c21_i64 = arith.constant 21 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.and %c0_i64, %0 : i64
    %2 = llvm.sext %arg2 : i32 to i64
    %3 = llvm.urem %c21_i64, %2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.xor %1, %4 : i64
    %6 = llvm.icmp "sle" %arg0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-45_i64 = arith.constant -45 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c45_i64 = arith.constant 45 : i64
    %0 = llvm.urem %c-7_i64, %c45_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.xor %arg1, %arg2 : i64
    %6 = llvm.select %4, %5, %c-45_i64 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-46_i64 = arith.constant -46 : i64
    %c-40_i64 = arith.constant -40 : i64
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.sdiv %c-13_i64, %arg0 : i64
    %1 = llvm.zext %arg1 : i1 to i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.and %c-40_i64, %c-46_i64 : i64
    %4 = llvm.and %arg2, %3 : i64
    %5 = llvm.srem %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.select %true, %c-30_i64, %1 : i1, i64
    %3 = llvm.select %arg0, %1, %2 : i1, i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-13_i64 = arith.constant -13 : i64
    %c41_i64 = arith.constant 41 : i64
    %false = arith.constant false
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %c-8_i64, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %c41_i64, %c-13_i64 : i64
    %3 = llvm.srem %2, %0 : i64
    %4 = llvm.select %false, %3, %3 : i1, i64
    %5 = llvm.sdiv %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.srem %3, %arg0 : i64
    %5 = llvm.lshr %c9_i64, %4 : i64
    %6 = llvm.srem %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %0 = llvm.icmp "sle" %arg1, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.icmp "ne" %arg1, %c-19_i64 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.xor %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c18_i64 = arith.constant 18 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.icmp "ule" %c18_i64, %c-43_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.xor %1, %1 : i64
    %3 = llvm.or %arg0, %arg1 : i64
    %4 = llvm.sdiv %3, %3 : i64
    %5 = llvm.sdiv %arg0, %4 : i64
    %6 = llvm.and %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-32_i64 = arith.constant -32 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.xor %arg0, %c20_i64 : i64
    %1 = llvm.sdiv %c-32_i64, %0 : i64
    %2 = llvm.ashr %arg1, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.and %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %c-37_i64, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i64
    %4 = llvm.or %3, %3 : i64
    %5 = llvm.ashr %arg0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.srem %arg2, %2 : i64
    %4 = llvm.lshr %arg1, %3 : i64
    %5 = llvm.or %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c20_i64 = arith.constant 20 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c50_i64 = arith.constant 50 : i64
    %c23_i64 = arith.constant 23 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.ashr %c23_i64, %c15_i64 : i64
    %1 = llvm.sdiv %0, %c50_i64 : i64
    %2 = llvm.icmp "eq" %0, %1 : i64
    %3 = llvm.ashr %arg0, %c-6_i64 : i64
    %4 = llvm.select %2, %0, %3 : i1, i64
    %5 = llvm.sdiv %4, %c20_i64 : i64
    %6 = llvm.icmp "slt" %5, %c42_i64 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.udiv %c39_i64, %1 : i64
    %3 = llvm.udiv %2, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.or %0, %4 : i64
    %6 = llvm.lshr %0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.or %0, %arg1 : i64
    %4 = llvm.lshr %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i32) -> i1 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sext %arg2 : i32 to i64
    %2 = llvm.select %arg1, %1, %1 : i1, i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "sgt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c11_i64 = arith.constant 11 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %c4_i64, %c11_i64 : i64
    %2 = llvm.and %arg0, %arg1 : i64
    %3 = llvm.and %1, %2 : i64
    %4 = llvm.and %0, %3 : i64
    %5 = llvm.sdiv %0, %arg2 : i64
    %6 = llvm.icmp "slt" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.or %arg2, %0 : i64
    %4 = llvm.ashr %arg1, %3 : i64
    %5 = llvm.xor %2, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.udiv %c-11_i64, %0 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.sext %5 : i32 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %c-10_i64 = arith.constant -10 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.sdiv %c42_i64, %arg0 : i64
    %1 = llvm.srem %arg0, %arg1 : i64
    %2 = llvm.sdiv %c-10_i64, %1 : i64
    %3 = llvm.xor %2, %c23_i64 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.icmp "sge" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.sdiv %4, %c34_i64 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.and %0, %c-49_i64 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.urem %2, %arg0 : i64
    %4 = llvm.sdiv %3, %0 : i64
    %5 = llvm.srem %4, %4 : i64
    %6 = llvm.lshr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c17_i64 = arith.constant 17 : i64
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.icmp "ule" %c-26_i64, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %arg1, %arg1 : i64
    %3 = llvm.and %2, %c17_i64 : i64
    %4 = llvm.xor %3, %2 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %c26_i64 = arith.constant 26 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.sdiv %c26_i64, %c44_i64 : i64
    %1 = llvm.urem %arg0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.or %arg0, %0 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.select %false, %4, %3 : i1, i64
    %6 = llvm.sdiv %5, %c-13_i64 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c6_i64 = arith.constant 6 : i64
    %c-13_i64 = arith.constant -13 : i64
    %false = arith.constant false
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.select %arg0, %arg1, %c50_i64 : i1, i64
    %1 = llvm.sext %false : i1 to i64
    %2 = llvm.and %1, %arg2 : i64
    %3 = llvm.and %c-13_i64, %c6_i64 : i64
    %4 = llvm.sdiv %3, %c-40_i64 : i64
    %5 = llvm.urem %2, %4 : i64
    %6 = llvm.select %true, %0, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 {
    %c-28_i64 = arith.constant -28 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-12_i64 = arith.constant -12 : i64
    %0 = llvm.and %c-41_i64, %c-12_i64 : i64
    %1 = llvm.zext %arg0 : i1 to i64
    %2 = llvm.urem %c-28_i64, %1 : i64
    %3 = llvm.sdiv %2, %2 : i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.urem %4, %0 : i64
    %6 = llvm.xor %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.or %arg2, %arg0 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.ashr %2, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c46_i64 = arith.constant 46 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.select %arg0, %c44_i64, %arg1 : i1, i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.select %3, %arg2, %2 : i1, i64
    %5 = llvm.srem %2, %c46_i64 : i64
    %6 = llvm.icmp "sge" %4, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c42_i64 = arith.constant 42 : i64
    %c39_i64 = arith.constant 39 : i64
    %c24_i64 = arith.constant 24 : i64
    %c3_i64 = arith.constant 3 : i64
    %0 = llvm.icmp "sge" %c24_i64, %c3_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %0, %arg0, %1 : i1, i64
    %3 = llvm.sdiv %2, %arg0 : i64
    %4 = llvm.xor %3, %c39_i64 : i64
    %5 = llvm.sdiv %4, %c42_i64 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %c44_i64 : i64
    %2 = llvm.trunc %arg0 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.sdiv %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-4_i64 = arith.constant -4 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %arg1, %arg2 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.urem %0, %2 : i64
    %4 = llvm.lshr %c-4_i64, %3 : i64
    %5 = llvm.udiv %4, %2 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-33_i64 = arith.constant -33 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %c-33_i64 : i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.lshr %c-20_i64, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    %6 = llvm.or %arg0, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %c37_i64 = arith.constant 37 : i64
    %true = arith.constant true
    %c-18_i64 = arith.constant -18 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.urem %c2_i64, %arg0 : i64
    %1 = llvm.lshr %c-18_i64, %0 : i64
    %2 = llvm.xor %arg1, %arg2 : i64
    %3 = llvm.ashr %c37_i64, %c-22_i64 : i64
    %4 = llvm.select %true, %3, %c-18_i64 : i1, i64
    %5 = llvm.and %2, %4 : i64
    %6 = llvm.icmp "slt" %1, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.and %c-44_i64, %c14_i64 : i64
    %1 = llvm.icmp "uge" %0, %arg0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    %3 = llvm.udiv %2, %arg0 : i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-43_i64 = arith.constant -43 : i64
    %c43_i32 = arith.constant 43 : i32
    %0 = llvm.sext %c43_i32 : i32 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %c-43_i64, %2 : i64
    %4 = llvm.trunc %arg1 : i64 to i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.icmp "ne" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-15_i64 = arith.constant -15 : i64
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.lshr %arg0, %c32_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.urem %2, %c-15_i64 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c46_i64 = arith.constant 46 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.sdiv %c46_i64, %c-42_i64 : i64
    %1 = llvm.or %arg0, %arg0 : i64
    %2 = llvm.urem %c-48_i64, %1 : i64
    %3 = llvm.and %2, %arg0 : i64
    %4 = llvm.sdiv %arg1, %3 : i64
    %5 = llvm.lshr %1, %4 : i64
    %6 = llvm.icmp "slt" %0, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i32) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.ashr %c-14_i64, %0 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.or %2, %c34_i64 : i64
    %4 = llvm.sdiv %3, %2 : i64
    %5 = llvm.udiv %4, %4 : i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
