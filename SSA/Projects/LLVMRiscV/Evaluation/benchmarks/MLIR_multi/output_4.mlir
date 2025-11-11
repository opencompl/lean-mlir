module {
  func.func @main(%arg0: i64) -> i1 {
    %c-7_i64 = arith.constant -7 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %c-43_i64, %0 : i64
    %2 = llvm.lshr %c-7_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %true = arith.constant true
    %c50_i64 = arith.constant 50 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sext %true : i1 to i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.icmp "sle" %c50_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-45_i64 = arith.constant -45 : i64
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.lshr %c-46_i64, %arg0 : i64
    %1 = llvm.urem %0, %c-45_i64 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    %2 = llvm.urem %1, %arg2 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.and %1, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %c-10_i64 = arith.constant -10 : i64
    %0 = llvm.udiv %c-10_i64, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "ule" %c-41_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i32) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.icmp "sge" %0, %1 : i64
    %3 = llvm.zext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-50_i64 = arith.constant -50 : i64
    %c-43_i64 = arith.constant -43 : i64
    %0 = llvm.and %c-50_i64, %c-43_i64 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.and %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-40_i64 = arith.constant -40 : i64
    %c-47_i64 = arith.constant -47 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %c-40_i64 : i1, i64
    %2 = llvm.xor %c-47_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.lshr %arg1, %arg0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.lshr %1, %c5_i64 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i32) -> i32 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.icmp "ne" %c-34_i64, %arg0 : i64
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-46_i64 = arith.constant -46 : i64
    %0 = llvm.ashr %arg1, %c-46_i64 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %c10_i64 : i64
    %2 = llvm.icmp "ne" %0, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c27_i64 = arith.constant 27 : i64
    %c-28_i64 = arith.constant -28 : i64
    %0 = llvm.sdiv %c-28_i64, %arg0 : i64
    %1 = llvm.icmp "eq" %0, %c27_i64 : i64
    %2 = llvm.select %1, %arg0, %arg0 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg0 : i1, i64
    %2 = llvm.urem %1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c14_i64 = arith.constant 14 : i64
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.ashr %arg1, %c14_i64 : i64
    %3 = llvm.or %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i1 {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.srem %0, %0 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.udiv %c25_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.xor %arg1, %arg0 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c32_i64 = arith.constant 32 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %c32_i64 : i64
    %2 = llvm.lshr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-50_i64 = arith.constant -50 : i64
    %c-8_i64 = arith.constant -8 : i64
    %0 = llvm.ashr %c-50_i64, %c-8_i64 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c27_i64 = arith.constant 27 : i64
    %0 = llvm.sdiv %arg0, %c27_i64 : i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %c10_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i32 {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.srem %arg1, %arg1 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %arg1, %c-41_i64 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.and %arg1, %1 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-11_i64 = arith.constant -11 : i64
    %0 = llvm.and %arg0, %c-11_i64 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.srem %arg2, %arg2 : i64
    %3 = llvm.lshr %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c18_i64 = arith.constant 18 : i64
    %c2_i64 = arith.constant 2 : i64
    %0 = llvm.or %arg1, %c2_i64 : i64
    %1 = llvm.and %0, %c18_i64 : i64
    %2 = llvm.udiv %1, %arg1 : i64
    %3 = llvm.icmp "sge" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.xor %1, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-50_i64 = arith.constant -50 : i64
    %0 = llvm.lshr %c-50_i64, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.sdiv %1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %c-36_i64 = arith.constant -36 : i64
    %c33_i64 = arith.constant 33 : i64
    %0 = llvm.lshr %c33_i64, %arg0 : i64
    %1 = llvm.and %0, %c5_i64 : i64
    %2 = llvm.icmp "uge" %c-36_i64, %1 : i64
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %c-34_i64 = arith.constant -34 : i64
    %0 = llvm.srem %c-34_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.srem %c-7_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-20_i64 = arith.constant -20 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg1 : i64
    %2 = llvm.xor %1, %c-20_i64 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.icmp "sle" %arg2, %arg1 : i64
    %2 = llvm.select %1, %arg2, %c-21_i64 : i1, i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %false = arith.constant false
    %c-13_i64 = arith.constant -13 : i64
    %0 = llvm.icmp "sge" %c-13_i64, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.select %false, %1, %arg1 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c37_i64 = arith.constant 37 : i64
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %c37_i64 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.srem %arg0, %c-29_i64 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.or %c5_i64, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.xor %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.lshr %c-21_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-34_i64 = arith.constant -34 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.urem %c-41_i64, %arg0 : i64
    %1 = llvm.urem %c-12_i64, %0 : i64
    %2 = llvm.lshr %1, %c-34_i64 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c25_i64 = arith.constant 25 : i64
    %0 = llvm.sdiv %c25_i64, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "sle" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c1_i64 = arith.constant 1 : i64
    %c46_i64 = arith.constant 46 : i64
    %0 = llvm.and %c46_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.or %2, %c1_i64 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %arg0 : i64
    %2 = llvm.sdiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c38_i64 = arith.constant 38 : i64
    %c-15_i64 = arith.constant -15 : i64
    %c24_i64 = arith.constant 24 : i64
    %0 = llvm.and %c24_i64, %arg0 : i64
    %1 = llvm.srem %c-15_i64, %c38_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-7_i64 = arith.constant -7 : i64
    %true = arith.constant true
    %c-4_i64 = arith.constant -4 : i64
    %c38_i64 = arith.constant 38 : i64
    %0 = llvm.select %true, %c-4_i64, %c38_i64 : i1, i64
    %1 = llvm.srem %c-7_i64, %arg0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-37_i64 = arith.constant -37 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %c-37_i64, %arg1 : i64
    %2 = llvm.xor %c20_i64, %1 : i64
    %3 = llvm.sdiv %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c10_i64 = arith.constant 10 : i64
    %c48_i64 = arith.constant 48 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.select %1, %arg1, %c48_i64 : i1, i64
    %3 = llvm.select %0, %2, %c10_i64 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-21_i64 = arith.constant -21 : i64
    %c40_i32 = arith.constant 40 : i32
    %0 = llvm.sext %c40_i32 : i32 to i64
    %1 = llvm.urem %arg0, %c-21_i64 : i64
    %2 = llvm.xor %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg1, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %c20_i64 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-23_i64 = arith.constant -23 : i64
    %c12_i64 = arith.constant 12 : i64
    %c20_i64 = arith.constant 20 : i64
    %0 = llvm.srem %arg0, %c20_i64 : i64
    %1 = llvm.and %c-23_i64, %0 : i64
    %2 = llvm.lshr %0, %1 : i64
    %3 = llvm.lshr %c12_i64, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c19_i64 = arith.constant 19 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.udiv %arg1, %0 : i64
    %2 = llvm.srem %arg0, %1 : i64
    %3 = llvm.icmp "ugt" %c19_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-7_i64 = arith.constant -7 : i64
    %0 = llvm.srem %c-7_i64, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.select %1, %2, %0 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-30_i64 = arith.constant -30 : i64
    %c-37_i64 = arith.constant -37 : i64
    %0 = llvm.select %arg0, %c-37_i64, %arg1 : i1, i64
    %1 = llvm.trunc %c-30_i64 : i64 to i1
    %2 = llvm.sext %1 : i1 to i64
    %3 = llvm.icmp "sgt" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %arg1, %arg2 : i64
    %2 = llvm.ashr %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.urem %arg1, %arg1 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c5_i64 = arith.constant 5 : i64
    %0 = llvm.udiv %arg0, %c5_i64 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %c11_i64 = arith.constant 11 : i64
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %c11_i64 : i64
    %2 = llvm.udiv %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.udiv %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c27_i32 = arith.constant 27 : i32
    %0 = llvm.sext %c27_i32 : i32 to i64
    %1 = llvm.or %arg1, %0 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c30_i64 = arith.constant 30 : i64
    %true = arith.constant true
    %0 = llvm.sext %true : i1 to i64
    %1 = llvm.xor %c30_i64, %0 : i64
    %2 = llvm.and %arg0, %1 : i64
    %3 = llvm.ashr %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.srem %arg1, %0 : i64
    %2 = llvm.sdiv %arg0, %1 : i64
    %3 = llvm.and %2, %1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    %2 = llvm.srem %1, %arg0 : i64
    %3 = llvm.icmp "eq" %c-31_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.trunc %arg0 : i64 to i1
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.urem %0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c10_i64 = arith.constant 10 : i64
    %false = arith.constant false
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.select %false, %c10_i64, %0 : i1, i64
    %2 = llvm.srem %c36_i64, %1 : i64
    %3 = llvm.icmp "ult" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-40_i64 = arith.constant -40 : i64
    %0 = llvm.trunc %c-40_i64 : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i32 {
    %c-28_i64 = arith.constant -28 : i64
    %c-21_i64 = arith.constant -21 : i64
    %0 = llvm.and %arg1, %c-21_i64 : i64
    %1 = llvm.or %arg0, %0 : i64
    %2 = llvm.or %c-28_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c17_i64 = arith.constant 17 : i64
    %0 = llvm.urem %c17_i64, %arg0 : i64
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.icmp "ne" %0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 {
    %c-40_i64 = arith.constant -40 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-12_i64 = arith.constant -12 : i64
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.sdiv %arg1, %c-45_i64 : i64
    %1 = llvm.srem %c0_i64, %c-40_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.select %arg0, %c-12_i64, %2 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-48_i64 = arith.constant -48 : i64
    %c-41_i64 = arith.constant -41 : i64
    %0 = llvm.ashr %c-41_i64, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    %2 = llvm.urem %arg0, %c-48_i64 : i64
    %3 = llvm.icmp "uge" %1, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.udiv %1, %arg2 : i64
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-45_i64 = arith.constant -45 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    %2 = llvm.urem %0, %1 : i64
    %3 = llvm.icmp "sge" %c-45_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c31_i64 = arith.constant 31 : i64
    %0 = llvm.lshr %c31_i64, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sext %2 : i32 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.icmp "ne" %arg0, %c-31_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.xor %1, %arg0 : i64
    %3 = llvm.or %2, %arg0 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c23_i64 = arith.constant 23 : i64
    %0 = llvm.trunc %arg0 : i64 to i1
    %1 = llvm.select %0, %arg0, %c23_i64 : i1, i64
    %2 = llvm.trunc %1 : i64 to i1
    %3 = llvm.sext %2 : i1 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c16_i64 = arith.constant 16 : i64
    %c-16_i64 = arith.constant -16 : i64
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.ashr %c-16_i64, %c16_i64 : i64
    %2 = llvm.select %0, %1, %1 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c0_i64 = arith.constant 0 : i64
    %c6_i64 = arith.constant 6 : i64
    %c15_i64 = arith.constant 15 : i64
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.select %1, %c6_i64, %c0_i64 : i1, i64
    %3 = llvm.icmp "uge" %c15_i64, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c-31_i64 = arith.constant -31 : i64
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %0, %c-31_i64 : i64
    %2 = llvm.or %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c-5_i64 = arith.constant -5 : i64
    %c26_i64 = arith.constant 26 : i64
    %0 = llvm.icmp "sge" %arg0, %c26_i64 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.ashr %c-5_i64, %1 : i64
    %3 = llvm.sdiv %2, %arg1 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.lshr %1, %0 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c7_i64 = arith.constant 7 : i64
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    %2 = llvm.xor %c7_i64, %1 : i64
    %3 = llvm.icmp "ne" %2, %arg1 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i32 {
    %c28_i64 = arith.constant 28 : i64
    %false = arith.constant false
    %0 = llvm.sext %false : i1 to i64
    %1 = llvm.trunc %0 : i64 to i1
    %2 = llvm.select %1, %arg0, %c28_i64 : i1, i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %c-22_i64 = arith.constant -22 : i64
    %c1_i64 = arith.constant 1 : i64
    %0 = llvm.xor %arg0, %c1_i64 : i64
    %1 = llvm.ashr %c-22_i64, %0 : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 {
    %c-26_i64 = arith.constant -26 : i64
    %0 = llvm.select %arg0, %c-26_i64, %arg1 : i1, i64
    %1 = llvm.ashr %0, %0 : i64
    %2 = llvm.and %1, %arg1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %c-1_i64 : i64
    %2 = llvm.or %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 {
    %c2_i64 = arith.constant 2 : i64
    %c-29_i64 = arith.constant -29 : i64
    %0 = llvm.trunc %c-29_i64 : i64 to i1
    %1 = llvm.srem %arg0, %arg0 : i64
    %2 = llvm.lshr %c2_i64, %1 : i64
    %3 = llvm.select %0, %2, %arg1 : i1, i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i32 {
    %c36_i64 = arith.constant 36 : i64
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.ashr %c36_i64, %0 : i64
    %2 = llvm.urem %arg0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i32
    return %3 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.zext %2 : i32 to i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 {
    %c-15_i64 = arith.constant -15 : i64
    %false = arith.constant false
    %0 = llvm.select %false, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    %2 = llvm.udiv %c-15_i64, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
