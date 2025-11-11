module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c22_i64 = arith.constant 22 : i64
    %true = arith.constant true
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.srem %arg1, %c4_i64 : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.and %c22_i64, %1 : i64
    %3 = llvm.select %true, %1, %2 : i1, i64
    %4 = llvm.select %arg0, %arg1, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-20_i64 = arith.constant -20 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.icmp "uge" %c-20_i64, %c-41_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.sdiv %1, %arg0 : i64
    %3 = llvm.udiv %c36_i64, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c49_i64 = arith.constant 49 : i64
    %0 = llvm.ashr %c10_i64, %c49_i64 : i64
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.urem %1, %arg0 : i64
    %3 = llvm.sdiv %0, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.udiv %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.sdiv %c-15_i64, %c-15_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.or %arg0, %2 : i64
    %4 = llvm.or %3, %arg1 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i32 {
    %c44_i64 = arith.constant 44 : i64
    %c-14_i64 = arith.constant -14 : i64
    %0 = llvm.select %arg0, %arg1, %c-14_i64 : i1, i64
    %1 = llvm.icmp "ult" %c44_i64, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sge" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.select %arg1, %0, %0 : i1, i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "ult" %2, %arg2 : i64
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.lshr %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %c26_i64, %arg1 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.sdiv %arg0, %2 : i64
    %4 = llvm.lshr %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i32) -> i1 {
    %c-9_i64 = arith.constant -9 : i64
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.sdiv %c-9_i64, %c-22_i64 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.urem %1, %1 : i64
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.xor %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.or %0, %arg2 : i64
    %2 = llvm.srem %1, %c-9_i64 : i64
    %3 = llvm.sdiv %2, %arg2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.urem %4, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.sdiv %1, %arg1 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-41_i64 = arith.constant -41 : i64
    %c1_i64 = arith.constant 1 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %arg0 : i64
    %2 = llvm.sdiv %c1_i64, %1 : i64
    %3 = llvm.ashr %2, %1 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.xor %4, %c-41_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %c-15_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c15_i64 = arith.constant 15 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-32_i64 = arith.constant -32 : i64
    %0 = llvm.trunc %c-32_i64 : i64 to i1
    %1 = llvm.xor %arg0, %arg1 : i64
    %2 = llvm.and %c15_i64, %1 : i64
    %3 = llvm.xor %2, %arg0 : i64
    %4 = llvm.select %0, %c-1_i64, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg2, %c31_i64 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.select %2, %c-31_i64, %arg1 : i1, i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.udiv %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.or %arg1, %c-23_i64 : i64
    %1 = llvm.lshr %arg1, %0 : i64
    %2 = llvm.and %c2_i64, %arg1 : i64
    %3 = llvm.urem %2, %arg1 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.select %arg0, %4, %2 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg1, %arg0 : i1, i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.lshr %arg1, %1 : i64
    %4 = llvm.sdiv %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.lshr %1, %arg0 : i64
    %3 = llvm.lshr %arg2, %2 : i64
    %4 = llvm.and %arg0, %3 : i64
    %5 = llvm.srem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %c13_i64 = arith.constant 13 : i64
    %false = arith.constant false
    %c18_i64 = arith.constant 18 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.lshr %arg0, %c-3_i64 : i64
    %1 = llvm.and %c-36_i64, %c18_i64 : i64
    %2 = llvm.icmp "ult" %0, %1 : i64
    %3 = llvm.select %2, %1, %0 : i1, i64
    %4 = llvm.select %false, %c13_i64, %c48_i64 : i1, i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-28_i64 = arith.constant -28 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %c40_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %3, %c-28_i64 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i32 {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.or %1, %arg0 : i64
    %3 = llvm.select %arg1, %2, %0 : i1, i64
    %4 = llvm.udiv %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 {
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.urem %arg0, %c50_i64 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.icmp "slt" %0, %3 : i64
    %5 = llvm.zext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c20_i32 = arith.constant 20 : i32
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.ashr %1, %0 : i64
    %3 = llvm.sext %c20_i32 : i32 to i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-19_i64 = arith.constant -19 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %c24_i64, %0 : i64
    %2 = llvm.or %c-19_i64, %arg0 : i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.xor %0, %arg2 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.icmp "ule" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c33_i64 = arith.constant 33 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.sdiv %c26_i64, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.or %c33_i64, %arg2 : i64
    %4 = llvm.select %2, %c-41_i64, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %c44_i64 = arith.constant 44 : i64
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sdiv %c44_i64, %c25_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.udiv %c-11_i64, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.icmp "sle" %arg1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c45_i64 = arith.constant 45 : i64
    %c-9_i64 = arith.constant -9 : i64
    %0 = llvm.lshr %c-9_i64, %arg0 : i64
    %1 = llvm.icmp "ugt" %c45_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.sdiv %0, %c45_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.trunc %c-17_i64 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.lshr %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.xor %arg1, %arg0 : i64
    %4 = llvm.icmp "uge" %2, %3 : i64
    %5 = llvm.sext %4 : i1 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c34_i64 = arith.constant 34 : i64
    %0 = llvm.icmp "sgt" %arg0, %c34_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.udiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-15_i64 = arith.constant -15 : i64
    %c13_i64 = arith.constant 13 : i64
    %c-23_i64 = arith.constant -23 : i64
    %c-19_i64 = arith.constant -19 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.srem %c-19_i64, %c38_i64 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.lshr %1, %c-23_i64 : i64
    %3 = llvm.ashr %c13_i64, %c-15_i64 : i64
    %4 = llvm.ashr %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %c-29_i64 = arith.constant -29 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.sdiv %c48_i64, %c-29_i64 : i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.icmp "ule" %0, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ugt" %4, %1 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-10_i64 = arith.constant -10 : i64
    %true = arith.constant true
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.xor %c27_i64, %arg0 : i64
    %1 = llvm.xor %0, %arg1 : i64
    %2 = llvm.select %true, %1, %c-10_i64 : i1, i64
    %3 = llvm.sdiv %2, %0 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-14_i64 = arith.constant -14 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c-41_i64 = arith.constant -41 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "ugt" %0, %c-37_i64 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ugt" %arg2, %c-41_i64 : i64
    %4 = llvm.select %3, %c-1_i64, %c-14_i64 : i1, i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-41_i64 = arith.constant -41 : i64
    %c11_i64 = arith.constant 11 : i64
    %c-3_i64 = arith.constant -3 : i64
    %0 = llvm.icmp "sge" %c-3_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.urem %c11_i64, %1 : i64
    %3 = llvm.urem %1, %c-41_i64 : i64
    %4 = llvm.udiv %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %c44_i64 = arith.constant 44 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.or %c40_i64, %arg0 : i64
    %1 = llvm.udiv %c44_i64, %0 : i64
    %2 = llvm.or %1, %1 : i64
    %3 = llvm.udiv %arg1, %arg2 : i64
    %4 = llvm.udiv %3, %c-26_i64 : i64
    %5 = llvm.icmp "sge" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.or %1, %arg1 : i64
    %3 = llvm.ashr %arg1, %2 : i64
    %4 = llvm.udiv %arg1, %3 : i64
    %5 = llvm.icmp "ult" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c9_i64 = arith.constant 9 : i64
    %c45_i64 = arith.constant 45 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.or %c2_i64, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    %2 = llvm.icmp "sge" %c45_i64, %arg2 : i64
    %3 = llvm.select %2, %c9_i64, %1 : i1, i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 {
    %c34_i64 = arith.constant 34 : i64
    %c-6_i64 = arith.constant -6 : i64
    %c22_i64 = arith.constant 22 : i64
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.ashr %c22_i64, %1 : i64
    %3 = llvm.udiv %2, %c-6_i64 : i64
    %4 = llvm.lshr %arg2, %c34_i64 : i64
    %5 = llvm.icmp "ule" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.xor %c32_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.ashr %4, %0 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %arg0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.zext %4 : i32 to i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c36_i64 = arith.constant 36 : i64
    %c-4_i32 = arith.constant -4 : i32
    %0 = llvm.sext %c-4_i32 : i32 to i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.sdiv %1, %1 : i64
    %3 = llvm.ashr %0, %arg2 : i64
    %4 = llvm.or %3, %c36_i64 : i64
    %5 = llvm.select %arg0, %2, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i32) -> i32 {
    %c-4_i64 = arith.constant -4 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sext %arg2 : i32 to i64
    %1 = llvm.select %arg1, %0, %c-28_i64 : i1, i64
    %2 = llvm.select %arg0, %1, %c-4_i64 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %true = arith.constant true
    %c46_i64 = arith.constant 46 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.ashr %c46_i64, %c20_i64 : i64
    %1 = llvm.select %true, %arg0, %0 : i1, i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "ugt" %arg1, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "uge" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-16_i64 = arith.constant -16 : i64
    %c13_i64 = arith.constant 13 : i64
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.sdiv %c23_i64, %arg0 : i64
    %1 = llvm.trunc %c13_i64 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.srem %0, %2 : i64
    %4 = llvm.ashr %3, %c-16_i64 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i1, %arg2: i64) -> i1 {
    %c-2_i64 = arith.constant -2 : i64
    %c25_i64 = arith.constant 25 : i64
    %c6_i64 = arith.constant 6 : i64
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.and %0, %c6_i64 : i64
    %2 = llvm.urem %1, %c25_i64 : i64
    %3 = llvm.urem %2, %c-2_i64 : i64
    %4 = llvm.select %arg1, %2, %arg2 : i1, i64
    %5 = llvm.icmp "uge" %3, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.icmp "ule" %arg2, %arg2 : i64
    %3 = llvm.ashr %1, %arg1 : i64
    %4 = llvm.select %2, %c-23_i64, %3 : i1, i64
    %5 = llvm.icmp "sgt" %1, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %c-16_i64 = arith.constant -16 : i64
    %c-34_i64 = arith.constant -34 : i64
    %c49_i64 = arith.constant 49 : i64
    %c8_i64 = arith.constant 8 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %c8_i64, %c49_i64 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.or %2, %c-34_i64 : i64
    %4 = llvm.srem %c-16_i64, %1 : i64
    %5 = llvm.udiv %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %arg1, %arg1 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.udiv %arg1, %2 : i64
    %4 = llvm.udiv %3, %arg2 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg1, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c40_i64 = arith.constant 40 : i64
    %c-48_i64 = arith.constant -48 : i64
    %0 = llvm.trunc %c-48_i64 : i64 to i1
    %1 = llvm.ashr %arg0, %arg0 : i64
    %2 = llvm.select %0, %c40_i64, %1 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.ashr %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %c-31_i64, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %c-43_i64, %0 : i64
    %2 = llvm.udiv %arg1, %1 : i64
    %3 = llvm.lshr %2, %1 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c40_i64 = arith.constant 40 : i64
    %0 = llvm.udiv %c40_i64, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.icmp "ult" %c-1_i64, %2 : i64
    %4 = llvm.urem %0, %arg1 : i64
    %5 = llvm.select %3, %0, %4 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-15_i64 = arith.constant -15 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.or %c-15_i64, %1 : i64
    %3 = llvm.or %2, %1 : i64
    %4 = llvm.udiv %c25_i64, %3 : i64
    %5 = llvm.and %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-49_i64 = arith.constant -49 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.udiv %arg1, %c-8_i64 : i64
    %1 = llvm.udiv %0, %arg2 : i64
    %2 = llvm.lshr %1, %arg2 : i64
    %3 = llvm.srem %arg0, %2 : i64
    %4 = llvm.udiv %0, %c-49_i64 : i64
    %5 = llvm.srem %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-15_i64 = arith.constant -15 : i64
    %c22_i64 = arith.constant 22 : i64
    %c47_i64 = arith.constant 47 : i64
    %c17_i64 = arith.constant 17 : i64
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.trunc %c25_i64 : i64 to i1
    %1 = llvm.icmp "ult" %c17_i64, %c47_i64 : i64
    %2 = llvm.sdiv %c22_i64, %c-15_i64 : i64
    %3 = llvm.select %1, %2, %arg0 : i1, i64
    %4 = llvm.select %0, %3, %3 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32, %arg1: i64) -> i64 {
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.trunc %3 : i64 to i1
    %5 = llvm.select %4, %arg1, %c48_i64 : i1, i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c29_i64 = arith.constant 29 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sdiv %2, %c-1_i64 : i64
    %4 = llvm.sdiv %3, %c29_i64 : i64
    %5 = llvm.urem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c13_i64 = arith.constant 13 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.or %c-17_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %c13_i64 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    %3 = llvm.ashr %arg0, %arg0 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.icmp "sle" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i32 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.select %arg2, %arg0, %1 : i1, i64
    %3 = llvm.xor %arg1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c9_i64 = arith.constant 9 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "sle" %c9_i64, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c45_i64 = arith.constant 45 : i64
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.udiv %arg1, %arg2 : i64
    %1 = llvm.sdiv %0, %c36_i64 : i64
    %2 = llvm.sdiv %1, %c45_i64 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.urem %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c26_i64 = arith.constant 26 : i64
    %c-23_i64 = arith.constant -23 : i64
    %0 = llvm.lshr %c26_i64, %c-23_i64 : i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.urem %2, %0 : i64
    %4 = llvm.srem %3, %c1_i64 : i64
    %5 = llvm.sdiv %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.ashr %0, %arg1 : i64
    %4 = llvm.srem %3, %arg1 : i64
    %5 = llvm.icmp "ugt" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %arg1 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    %4 = llvm.ashr %arg0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c39_i64 = arith.constant 39 : i64
    %0 = llvm.trunc %c39_i64 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-17_i64 = arith.constant -17 : i64
    %c41_i64 = arith.constant 41 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.urem %c41_i64, %c4_i64 : i64
    %1 = llvm.urem %0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.srem %arg0, %arg1 : i64
    %4 = llvm.sdiv %c-17_i64, %3 : i64
    %5 = llvm.sdiv %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-6_i64 = arith.constant -6 : i64
    %false = arith.constant false
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %c-1_i64 : i64
    %1 = llvm.and %arg1, %arg2 : i64
    %2 = llvm.select %false, %0, %c-6_i64 : i1, i64
    %3 = llvm.sdiv %1, %2 : i64
    %4 = llvm.sdiv %1, %3 : i64
    %5 = llvm.xor %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-6_i64 = arith.constant -6 : i64
    %0 = llvm.icmp "sgt" %arg0, %c-6_i64 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.icmp "sle" %arg0, %arg0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.xor %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c42_i64 = arith.constant 42 : i64
    %c-38_i64 = arith.constant -38 : i64
    %c49_i64 = arith.constant 49 : i64
    %true = arith.constant true
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.select %true, %arg0, %c-41_i64 : i1, i64
    %1 = llvm.and %c-38_i64, %c42_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.xor %arg0, %2 : i64
    %4 = llvm.ashr %c49_i64, %3 : i64
    %5 = llvm.icmp "ule" %4, %0 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-46_i64 = arith.constant -46 : i64
    %c-33_i64 = arith.constant -33 : i64
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c0_i64, %c-33_i64 : i64
    %2 = llvm.sdiv %1, %0 : i64
    %3 = llvm.xor %arg0, %c-46_i64 : i64
    %4 = llvm.and %2, %3 : i64
    %5 = llvm.srem %0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %c-28_i64 = arith.constant -28 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.sdiv %c-34_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.udiv %c-28_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.xor %4, %c28_i64 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c29_i64 = arith.constant 29 : i64
    %true = arith.constant true
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    %2 = llvm.select %true, %0, %c29_i64 : i1, i64
    %3 = llvm.urem %1, %2 : i64
    %4 = llvm.urem %c-39_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.sdiv %arg1, %c-21_i64 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %0, %arg2 : i64
    %3 = llvm.srem %1, %2 : i64
    %4 = llvm.xor %2, %arg0 : i64
    %5 = llvm.lshr %3, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c28_i64 = arith.constant 28 : i64
    %true = arith.constant true
    %0 = llvm.select %true, %arg2, %arg2 : i1, i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.xor %1, %c28_i64 : i64
    %3 = llvm.xor %2, %0 : i64
    %4 = llvm.and %1, %3 : i64
    %5 = llvm.lshr %arg0, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %false = arith.constant false
    %c-46_i64 = arith.constant -46 : i64
    %c-39_i64 = arith.constant -39 : i64
    %0 = llvm.select %false, %c-46_i64, %c-39_i64 : i1, i64
    %1 = llvm.select %false, %0, %arg0 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.udiv %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-15_i64 = arith.constant -15 : i64
    %c-5_i32 = arith.constant -5 : i32
    %0 = llvm.sext %c-5_i32 : i32 to i64
    %1 = llvm.ashr %c-15_i64, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.lshr %0, %2 : i64
    %4 = llvm.urem %3, %2 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    %2 = llvm.ashr %1, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.icmp "eq" %c23_i64, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c25_i64 = arith.constant 25 : i64
    %c-18_i64 = arith.constant -18 : i64
    %c-17_i64 = arith.constant -17 : i64
    %0 = llvm.icmp "ule" %c-18_i64, %c-17_i64 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.udiv %1, %1 : i64
    %3 = llvm.xor %2, %arg2 : i64
    %4 = llvm.or %1, %3 : i64
    %5 = llvm.urem %c25_i64, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c9_i64 = arith.constant 9 : i64
    %c-2_i64 = arith.constant -2 : i64
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "ule" %0, %c5_i64 : i64
    %2 = llvm.select %1, %0, %c-2_i64 : i1, i64
    %3 = llvm.lshr %2, %c9_i64 : i64
    %4 = llvm.urem %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.lshr %arg0, %c-5_i64 : i64
    %1 = llvm.udiv %c5_i64, %0 : i64
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.srem %1, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-25_i64 = arith.constant -25 : i64
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.lshr %c-11_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.srem %c-25_i64, %3 : i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.select %0, %3, %arg0 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c9_i64 = arith.constant 9 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.ashr %arg0, %c-21_i64 : i64
    %1 = llvm.urem %0, %c9_i64 : i64
    %2 = llvm.srem %arg1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.urem %1, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-24_i64 = arith.constant -24 : i64
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %arg0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.and %c-24_i64, %2 : i64
    %4 = llvm.and %3, %0 : i64
    %5 = llvm.icmp "ult" %arg0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c-5_i64 = arith.constant -5 : i64
    %0 = llvm.sext %arg0 : i32 to i64
    %1 = llvm.ashr %0, %c-40_i64 : i64
    %2 = llvm.sdiv %c-5_i64, %1 : i64
    %3 = llvm.trunc %0 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.ashr %2, %4 : i64
    return %5 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c12_i64 = arith.constant 12 : i64
    %c-35_i64 = arith.constant -35 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c4_i64 = arith.constant 4 : i64
    %0 = llvm.udiv %c4_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %c-27_i64, %0 : i64
    %2 = llvm.or %arg2, %c-35_i64 : i64
    %3 = llvm.urem %arg1, %2 : i64
    %4 = llvm.select %1, %3, %c12_i64 : i1, i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.urem %c25_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %c-22_i64 = arith.constant -22 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.xor %c-22_i64, %arg2 : i64
    %2 = llvm.icmp "sle" %arg0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    %4 = llvm.xor %3, %1 : i64
    %5 = llvm.icmp "uge" %0, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-12_i64 = arith.constant -12 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.xor %c-12_i64, %c-16_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.lshr %1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c27_i64 = arith.constant 27 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.udiv %c27_i64, %c-46_i64 : i64
    %1 = llvm.or %c-46_i64, %arg1 : i64
    %2 = llvm.urem %1, %c5_i64 : i64
    %3 = llvm.udiv %arg0, %2 : i64
    %4 = llvm.xor %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-47_i64 = arith.constant -47 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.and %c-1_i64, %c31_i64 : i64
    %1 = llvm.srem %c-47_i64, %arg0 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.trunc %4 : i64 to i32
    return %5 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %c21_i64 = arith.constant 21 : i64
    %c-27_i64 = arith.constant -27 : i64
    %0 = llvm.srem %c21_i64, %c-27_i64 : i64
    %1 = llvm.lshr %c5_i64, %0 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.ashr %2, %arg0 : i64
    %4 = llvm.sdiv %0, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-44_i64 = arith.constant -44 : i64
    %0 = llvm.lshr %arg0, %c-44_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.udiv %0, %2 : i64
    %4 = llvm.srem %2, %3 : i64
    %5 = llvm.trunc %4 : i64 to i1
    return %5 : i1
  }
}
// -----
