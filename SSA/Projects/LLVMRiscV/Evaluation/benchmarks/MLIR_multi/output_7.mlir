module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c-25_i64 = arith.constant -25 : i64
    %c-38_i32 = arith.constant -38 : i32
    %0 = llvm.sext %c-38_i32 : i32 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.or %0, %arg1 : i64
    %3 = llvm.select %1, %2, %c-25_i64 : i1, i64
    %4 = llvm.urem %c-37_i64, %arg0 : i64
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
    %c-31_i64 = arith.constant -31 : i64
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.or %1, %c-31_i64 : i64
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
    %c-17_i64 = arith.constant -17 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.trunc %c-6_i64 : i64 to i1
    %1 = llvm.select %0, %arg0, %c-17_i64 : i1, i64
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
    %c-50_i64 = arith.constant -50 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.and %c-36_i64, %c-39_i64 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.urem %c-50_i64, %1 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %c-9_i64 = arith.constant -9 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.urem %c-3_i64, %arg0 : i64
    %1 = llvm.udiv %0, %c-9_i64 : i64
    %2 = llvm.xor %1, %c-23_i64 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.urem %arg0, %c31_i64 : i64
    %1 = llvm.and %c-44_i64, %0 : i64
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
    %c-50_i64 = arith.constant -50 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.and %c-41_i64, %c-50_i64 : i64
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
    %c-37_i32 = arith.constant -37 : i32
    %c-38_i64 = arith.constant -38 : i64
    %0 = llvm.icmp "slt" %arg0, %c-38_i64 : i64
    %1 = llvm.select %0, %arg1, %arg2 : i1, i64
    %2 = llvm.sext %c-37_i32 : i32 to i64
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
    %c-49_i64 = arith.constant -49 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.ashr %c-49_i64, %c-43_i64 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg2, %0 : i64
    %2 = llvm.ashr %c27_i64, %c-18_i64 : i64
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
    %c-23_i64 = arith.constant -23 : i64
    %c-29_i64 = arith.constant -29 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.udiv %c-29_i64, %c48_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.xor %2, %c-23_i64 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %c-40_i64 : i64 to i32
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
    %c-19_i64 = arith.constant -19 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.select %0, %c-19_i64, %1 : i1, i64
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
    %c-50_i64 = arith.constant -50 : i64
    %c34_i64 = arith.constant 34 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.and %c34_i64, %c22_i64 : i64
    %1 = llvm.xor %0, %c-50_i64 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %c38_i64 = arith.constant 38 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "uge" %c38_i64, %c-34_i64 : i64
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
    %c-49_i64 = arith.constant -49 : i64
    %c-32_i64 = arith.constant -32 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.sdiv %c-39_i64, %arg0 : i64
    %1 = llvm.udiv %arg0, %arg1 : i64
    %2 = llvm.sdiv %1, %c-7_i64 : i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.icmp "ne" %c-32_i64, %c-49_i64 : i64
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
    %c-47_i64 = arith.constant -47 : i64
    %c35_i64 = arith.constant 35 : i64
    %c-7_i64 = arith.constant -7 : i64
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.lshr %c-7_i64, %c-20_i64 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.lshr %1, %c35_i64 : i64
    %3 = llvm.and %0, %2 : i64
    %4 = llvm.icmp "ugt" %3, %c-47_i64 : i64
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-25_i64 = arith.constant -25 : i64
    %c-26_i64 = arith.constant -26 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "ule" %arg0, %arg1 : i64
    %1 = llvm.lshr %c-6_i64, %c-36_i64 : i64
    %2 = llvm.srem %arg2, %c-35_i64 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.sdiv %c-26_i64, %c-25_i64 : i64
    %5 = llvm.select %0, %3, %4 : i1, i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c48_i64 = arith.constant 48 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.select %arg0, %arg1, %c-41_i64 : i1, i64
    %3 = llvm.and %c48_i64, %2 : i64
    %4 = llvm.xor %c-44_i64, %3 : i64
    %5 = llvm.icmp "sle" %1, %4 : i64
    %6 = llvm.sext %5 : i1 to i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.select %arg0, %c-17_i64, %arg1 : i1, i64
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
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.ashr %c-23_i64, %1 : i64
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
    %c-17_i64 = arith.constant -17 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.urem %c23_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.srem %c-17_i64, %2 : i64
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
    %c-19_i64 = arith.constant -19 : i64
    %true = arith.constant true
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.select %true, %0, %c-19_i64 : i1, i64
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
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.select %arg1, %arg2, %c-14_i64 : i1, i64
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
    %c-37_i64 = arith.constant -37 : i64
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.lshr %arg2, %c-25_i64 : i64
    %3 = llvm.srem %arg0, %c-37_i64 : i64
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
    %c-20_i64 = arith.constant -20 : i64
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.lshr %c-20_i64, %c10_i64 : i64
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
    %c-9_i64 = arith.constant -9 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %c-44_i64, %arg0 : i64
    %1 = llvm.icmp "uge" %arg0, %arg0 : i64
    %2 = llvm.xor %arg0, %c7_i64 : i64
    %3 = llvm.srem %c-9_i64, %2 : i64
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
    %c-12_i64 = arith.constant -12 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.ashr %c-1_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.xor %arg2, %c-12_i64 : i64
    %6 = llvm.sdiv %4, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %c47_i64 = arith.constant 47 : i64
    %c-16_i64 = arith.constant -16 : i64
    %c-22_i64 = arith.constant -22 : i64
    %c41_i64 = arith.constant 41 : i64
    %0 = llvm.or %arg0, %c41_i64 : i64
    %1 = llvm.xor %c47_i64, %c7_i64 : i64
    %2 = llvm.udiv %c-16_i64, %1 : i64
    %3 = llvm.urem %c-22_i64, %2 : i64
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
    %c-9_i64 = arith.constant -9 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.ashr %arg0, %c21_i64 : i64
    %1 = llvm.select %arg1, %0, %arg2 : i1, i64
    %2 = llvm.srem %1, %arg2 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.srem %3, %c-9_i64 : i64
    %5 = llvm.ashr %0, %4 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i1 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.or %c-6_i64, %arg1 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.xor %c-7_i64, %c49_i64 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.trunc %c14_i64 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.xor %c-8_i64, %2 : i64
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
    %c-49_i64 = arith.constant -49 : i64
    %0 = llvm.udiv %c-49_i64, %arg1 : i64
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
    %c-16_i64 = arith.constant -16 : i64
    %c29_i64 = arith.constant 29 : i64
    %0 = llvm.icmp "ugt" %arg0, %c29_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.trunc %arg1 : i64 to i1
    %3 = llvm.select %2, %arg2, %c-16_i64 : i1, i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.sext %4 : i32 to i64
    %6 = llvm.ashr %1, %5 : i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-21_i64 = arith.constant -21 : i64
    %c12_i64 = arith.constant 12 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg2 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.icmp "ugt" %c12_i64, %c-21_i64 : i64
    %5 = llvm.select %4, %1, %1 : i1, i64
    %6 = llvm.icmp "uge" %3, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 {
    %c-3_i64 = arith.constant -3 : i64
    %c14_i64 = arith.constant 14 : i64
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.sdiv %arg0, %c-40_i64 : i64
    %1 = llvm.lshr %0, %c14_i64 : i64
    %2 = llvm.xor %c-3_i64, %1 : i64
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
    %c-40_i64 = arith.constant -40 : i64
    %c2_i64 = arith.constant 2 : i64
    %c-42_i64 = arith.constant -42 : i64
    %0 = llvm.urem %arg0, %c-42_i64 : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %c2_i64, %2 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.and %4, %c-40_i64 : i64
    %6 = llvm.trunc %5 : i64 to i32
    return %6 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-30_i64 = arith.constant -30 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %c-30_i64, %0 : i64
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
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %c-13_i64, %c34_i64 : i64
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
    %c-18_i64 = arith.constant -18 : i64
    %0 = llvm.and %c-18_i64, %arg0 : i64
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
    %c-34_i64 = arith.constant -34 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.and %arg0, %c-22_i64 : i64
    %1 = llvm.xor %0, %0 : i64
    %2 = llvm.sdiv %c-34_i64, %1 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.xor %arg0, %c-44_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.ashr %1, %c-10_i64 : i64
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
    %c-35_i64 = arith.constant -35 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.ashr %c4_i64, %arg1 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.zext %arg2 : i1 to i64
    %4 = llvm.ashr %c-35_i64, %3 : i64
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
    %c-44_i64 = arith.constant -44 : i64
    %c-35_i64 = arith.constant -35 : i64
    %0 = llvm.urem %arg0, %c-35_i64 : i64
    %1 = llvm.and %c-44_i64, %0 : i64
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
    %c-39_i64 = arith.constant -39 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %c-46_i64, %0 : i64
    %2 = llvm.xor %1, %arg1 : i64
    %3 = llvm.ashr %c-39_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.trunc %5 : i64 to i1
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-1_i64 = arith.constant -1 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.srem %c26_i64, %arg0 : i64
    %1 = llvm.lshr %arg0, %arg0 : i64
    %2 = llvm.icmp "slt" %arg0, %1 : i64
    %3 = llvm.select %2, %arg1, %c-1_i64 : i1, i64
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
    %c-24_i64 = arith.constant -24 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.sdiv %c-10_i64, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %arg0, %c-24_i64 : i64
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
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.srem %c-8_i64, %arg0 : i64
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
    %c-10_i64 = arith.constant -10 : i64
    %c37_i64 = arith.constant 37 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg0, %c-41_i64 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.lshr %arg1, %c-10_i64 : i64
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
    %c-43_i64 = arith.constant -43 : i64
    %c30_i64 = arith.constant 30 : i64
    %0 = llvm.ashr %arg0, %c30_i64 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.and %c-43_i64, %arg0 : i64
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
    %c-25_i64 = arith.constant -25 : i64
    %c21_i64 = arith.constant 21 : i64
    %0 = llvm.trunc %arg2 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %c21_i64 : i64 to i1
    %3 = llvm.sdiv %arg1, %c-25_i64 : i64
    %4 = llvm.select %2, %arg2, %3 : i1, i64
    %5 = llvm.ashr %1, %4 : i64
    %6 = llvm.select %arg0, %arg1, %5 : i1, i64
    return %6 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i32 {
    %c-14_i64 = arith.constant -14 : i64
    %c-46_i64 = arith.constant -46 : i64
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.icmp "uge" %c-46_i64, %c14_i64 : i64
    %1 = llvm.select %0, %c-14_i64, %arg0 : i1, i64
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
    %c-15_i64 = arith.constant -15 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %c48_i64 : i64 to i1
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.xor %c-15_i64, %1 : i64
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
    %c-7_i64 = arith.constant -7 : i64
    %c42_i64 = arith.constant 42 : i64
    %c8_i32 = arith.constant 8 : i32
    %0 = llvm.sext %c8_i32 : i32 to i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.or %1, %c42_i64 : i64
    %3 = llvm.sdiv %c-7_i64, %arg1 : i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.srem %arg0, %4 : i64
    %6 = llvm.icmp "uge" %2, %5 : i64
    return %6 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c-38_i64 = arith.constant -38 : i64
    %false = arith.constant false
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.or %arg1, %c-38_i64 : i64
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
    %c-4_i64 = arith.constant -4 : i64
    %c26_i64 = arith.constant 26 : i64
    %c42_i64 = arith.constant 42 : i64
    %0 = llvm.trunc %c42_i64 : i64 to i1
    %1 = llvm.xor %c-4_i64, %arg0 : i64
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
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.urem %1, %c-48_i64 : i64
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
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.icmp "ule" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.urem %c-5_i64, %arg0 : i64
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
    %c-2_i64 = arith.constant -2 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.zext %arg2 : i1 to i64
    %3 = llvm.srem %c-46_i64, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.icmp "eq" %1, %4 : i64
    %6 = llvm.select %5, %2, %c-2_i64 : i1, i64
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
    %c-27_i32 = arith.constant -27 : i32
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.select %arg0, %c46_i64, %arg1 : i1, i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.sext %c-27_i32 : i32 to i64
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
    %c-25_i64 = arith.constant -25 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %c-25_i64, %0 : i64
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
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.lshr %arg0, %c-24_i64 : i64
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
