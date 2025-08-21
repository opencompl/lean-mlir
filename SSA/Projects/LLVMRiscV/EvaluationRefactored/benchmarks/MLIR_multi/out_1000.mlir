module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 0 : index} {
    return %arg0 : i32
  }
}
// ----- thousand functions of 2 instructioons
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 1 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 2 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 3 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 4 : index} {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 5 : index} {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 6 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 7 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 8 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 9 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 10 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 11 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 12 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 13 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 14 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 15 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 16 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 17 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 18 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.ashr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 19 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 20 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 21 : index} {
    %0 = llvm.urem %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 22 : index} {
    %0 = llvm.shl %arg1, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 23 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 24 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 25 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 26 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 27 : index} {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 28 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 29 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 30 : index} {
    %0 = llvm.icmp "uge" %arg0, %arg0 : i64
    %1 = llvm.select %0, %arg1, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 31 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 32 : index} {
    %0 = llvm.urem %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 33 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.udiv %0, %arg2 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 34 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 35 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 36 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 37 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 38 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 39 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 40 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.add %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 41 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 42 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 43 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 44 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 45 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 46 : index} {
    %0 = llvm.icmp "sgt" %arg0, %arg0 : i64
    %1 = llvm.zext %0 : i1 to i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 47 : index} {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 48 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 49 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 50 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 51 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 52 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sdiv %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 53 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 54 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 55 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 56 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 57 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 58 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 59 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.xor %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 60 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 61 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 62 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 63 : index} {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 64 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 65 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 66 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 67 : index} {
    %0 = llvm.srem %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 68 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 69 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 70 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 71 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.mul %0, %arg2 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 72 : index} {
    %0 = llvm.sub %arg1, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 73 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.lshr %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 74 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 75 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 76 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 77 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 78 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 79 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 80 : index} {
    %0 = llvm.icmp "eq" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 81 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 82 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 83 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 84 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 85 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 86 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 87 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 88 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 89 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.srem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 90 : index} {
    %0 = llvm.urem %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 91 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 92 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 93 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 94 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.shl %0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 95 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 96 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.add %0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 97 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 98 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.icmp "sle" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 99 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 100 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 101 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 102 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 103 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 104 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 105 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 106 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 107 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 108 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 109 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.mul %0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 110 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 111 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 112 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 113 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 114 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.ashr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 115 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.or %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 116 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 117 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 118 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.srem %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 119 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 120 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 121 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 122 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.add %0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 123 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 124 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 125 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 126 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 127 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.urem %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 128 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 129 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.lshr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 130 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.ashr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 131 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.or %0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 132 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 133 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 134 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.srem %0, %arg2 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 135 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 136 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 137 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.sub %0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 138 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.add %0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 139 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.icmp "ne" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 140 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 141 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 142 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 143 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.urem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 144 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 145 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.lshr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 146 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 147 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.or %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 148 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 149 : index} {
    %0 = llvm.srem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.srem %0, %arg2 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 150 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.udiv %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 151 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 152 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 153 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.add %0, %arg2 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 154 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.icmp "slt" %0, %arg2 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 155 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.sdiv %0, %arg2 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 156 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.xor %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 157 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %1 = llvm.urem %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 158 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 159 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 160 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 161 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 162 : index} {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 163 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 164 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 165 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 166 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 167 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.add %0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 168 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "eq" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 169 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sdiv %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 170 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 171 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.urem %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 172 : index} {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 173 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 174 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 175 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 176 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 177 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 178 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 179 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.shl %0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 180 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 181 : index} {
    %0 = llvm.urem %arg0, %arg1 : i64
    %1 = llvm.add %0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 182 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "sgt" %0, %arg1 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 183 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 184 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 185 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.urem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 186 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 187 : index} {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.lshr %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 188 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 189 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.or %0, %arg1 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 190 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 191 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.srem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 192 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 193 : index} {
    %0 = llvm.sdiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.shl %0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 194 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 195 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.add %0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 196 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 197 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 198 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 199 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 200 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 201 : index} {
    %0 = llvm.sdiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.lshr %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 202 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.ashr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 203 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.or %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 204 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 205 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.srem %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 206 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 207 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 208 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 209 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.add %0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 210 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 211 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 212 : index} {
    %0 = llvm.sdiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 213 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 214 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 215 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.lshr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 216 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 217 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.or %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 218 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 219 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 220 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.udiv %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 221 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.shl %0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 222 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sub %0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 223 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.add %0, %arg2 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 224 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.icmp "ne" %0, %arg0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 225 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.sdiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 226 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 227 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.urem %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 228 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 229 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 230 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 231 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 232 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 233 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 234 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 235 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 236 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 237 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.add %0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 238 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 239 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 240 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.xor %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 241 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 242 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 243 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 244 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 245 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.or %0, %arg2 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 246 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 247 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.srem %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 248 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 249 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.shl %0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 250 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.sub %0, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 251 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.add %0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 252 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "ne" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 253 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.sdiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 254 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.xor %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 255 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.urem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 256 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 257 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.lshr %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 258 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.ashr %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 259 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.or %0, %arg1 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 260 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 261 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.srem %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 262 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.udiv %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 263 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.shl %0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 264 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.sub %0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 265 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.add %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 266 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.icmp "ugt" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 267 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 268 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 269 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.urem %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 270 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 271 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.lshr %0, %arg2 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 272 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 273 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.or %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 274 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 275 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.srem %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 276 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.udiv %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 277 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.shl %0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 278 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.sub %0, %arg2 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 279 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.add %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 280 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.icmp "ugt" %0, %arg0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 281 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sdiv %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 282 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.xor %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 283 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.urem %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 284 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 285 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.lshr %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 286 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg1 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 287 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 288 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 289 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 290 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 291 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.shl %0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 292 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 293 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.add %0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 294 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.icmp "sgt" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 295 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sdiv %0, %arg2 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 296 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 297 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.urem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 298 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 299 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 300 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 301 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 302 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 303 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 304 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 305 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.shl %0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 306 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    %1 = llvm.sub %0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 307 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.add %0, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 308 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    %1 = llvm.icmp "sge" %0, %arg1 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 309 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 310 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 311 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 312 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.mul %0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 313 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    %1 = llvm.lshr %0, %arg2 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 314 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 315 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 316 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 317 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.srem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 318 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.udiv %0, %arg0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 319 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.shl %0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 320 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sub %0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 321 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.add %0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 322 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.icmp "uge" %0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 323 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 324 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.xor %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 325 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.urem %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 326 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.mul %0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 327 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 328 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 329 : index} {
    %0 = llvm.srem %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 330 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 331 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 332 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 333 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 334 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 335 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 336 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 337 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 338 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 339 : index} {
    %0 = llvm.ashr %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 340 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 341 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 342 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 343 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 344 : index} {
    %0 = llvm.udiv %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 345 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 346 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 347 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 348 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 349 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 350 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 351 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 352 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 353 : index} {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 354 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 355 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 356 : index} {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 357 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 358 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 359 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 360 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 361 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 362 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 363 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 364 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 365 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 366 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 367 : index} {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 368 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 369 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 370 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 371 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 372 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 373 : index} {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 374 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 375 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 376 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 377 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 378 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 379 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 380 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 381 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 382 : index} {
    %0 = llvm.udiv %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 383 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 384 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 385 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 386 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 387 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 388 : index} {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 389 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 390 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 391 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 392 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 393 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 394 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 395 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 396 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 397 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 398 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 399 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 400 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 401 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 402 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 403 : index} {
    %0 = llvm.icmp "eq" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 404 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 405 : index} {
    %0 = llvm.sub %arg1, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 406 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 407 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 408 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 409 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 410 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 411 : index} {
    %0 = llvm.urem %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 412 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 413 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 414 : index} {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 415 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 416 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 417 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 418 : index} {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 419 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 420 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 421 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 422 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 423 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 424 : index} {
    %0 = llvm.icmp "ugt" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 425 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 426 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 427 : index} {
    %0 = llvm.urem %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 428 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 429 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 430 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 431 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 432 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 433 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 434 : index} {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 435 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 436 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 437 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 438 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 439 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 440 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 441 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 442 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 443 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 444 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 445 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 446 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 447 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 448 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 449 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 450 : index} {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 451 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 452 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 453 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 454 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 455 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 456 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 457 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 458 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 459 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 460 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 461 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 462 : index} {
    %0 = llvm.icmp "ne" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 463 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 464 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 465 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 466 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 467 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 468 : index} {
    %0 = llvm.ashr %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 469 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 470 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 471 : index} {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 472 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 473 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 474 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 475 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 476 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 477 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 478 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 479 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 480 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 481 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 482 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 483 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 484 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 485 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 486 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 487 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 488 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 489 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 490 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 491 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 492 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 493 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 494 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 495 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 496 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 497 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 498 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 499 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 500 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 501 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 502 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 503 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 504 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 505 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 506 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 507 : index} {
    %0 = llvm.ashr %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 508 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 509 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 510 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 511 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 512 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 513 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 514 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 515 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 516 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 517 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 518 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 519 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 520 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 521 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 522 : index} {
    %0 = llvm.urem %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 523 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 524 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 525 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 526 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 527 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 528 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 529 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 530 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 531 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 532 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 533 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 534 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 535 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 536 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 537 : index} {
    %0 = llvm.icmp "sle" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 538 : index} {
    %0 = llvm.sdiv %arg0, %arg1 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 539 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 540 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 541 : index} {
    %0 = llvm.zext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 542 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 543 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 544 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 545 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 546 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 547 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 548 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 549 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 550 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 551 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 552 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 553 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 554 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 555 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 556 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 557 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 558 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 559 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 560 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 561 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 562 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 563 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 564 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 565 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 566 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 567 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 568 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 569 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 570 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 571 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 572 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 573 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 574 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 575 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 576 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 577 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 578 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 579 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 580 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 581 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 582 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 583 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 584 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 585 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 586 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 587 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 588 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 589 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 590 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 591 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 592 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 593 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 594 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 595 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 596 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 597 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 598 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<none>} : i1 to i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 599 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 600 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 601 : index} {
    %0 = llvm.trunc %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i1 to i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 602 : index} {
    %0 = llvm.srem %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 603 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 604 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 605 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 606 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 607 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 608 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 609 : index} {
    %0 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 610 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 611 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 612 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 613 : index} {
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 614 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 615 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 616 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 617 : index} {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 618 : index} {
    %0 = llvm.select %arg1, %arg0, %arg2 : i1, i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 619 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 620 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 621 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 622 : index} {
    %0 = llvm.select %arg1, %arg2, %arg2 : i1, i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i1 attributes {seed = 623 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 624 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 625 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 626 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 627 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 628 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 629 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 630 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 631 : index} {
    %0 = llvm.select %arg1, %arg0, %arg0 : i1, i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 632 : index} {
    %0 = llvm.urem %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 633 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 634 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 635 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 636 : index} {
    %0 = llvm.srem %arg1, %arg0 {isExactFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 637 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 638 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 639 : index} {
    %0 = llvm.srem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 640 : index} {
    %0 = llvm.srem %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 641 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 642 : index} {
    %0 = llvm.urem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 643 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 644 : index} {
    %0 = llvm.srem %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 645 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 646 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 647 : index} {
    %0 = llvm.srem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 648 : index} {
    %0 = llvm.srem %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 649 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 650 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 651 : index} {
    %0 = llvm.srem %arg1, %arg0 {isExactFlag} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 652 : index} {
    %0 = llvm.srem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 653 : index} {
    %0 = llvm.srem %arg0, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 654 : index} {
    %0 = llvm.srem %arg1, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 655 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 656 : index} {
    %0 = llvm.srem %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 657 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 658 : index} {
    %0 = llvm.srem %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 659 : index} {
    %0 = llvm.srem %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 660 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 661 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 662 : index} {
    %0 = llvm.udiv %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 663 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 664 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 665 : index} {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 666 : index} {
    %0 = llvm.urem %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 667 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 668 : index} {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 669 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 670 : index} {
    %0 = llvm.urem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 671 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 672 : index} {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 673 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 674 : index} {
    %0 = llvm.urem %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 675 : index} {
    %0 = llvm.udiv %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 676 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 677 : index} {
    %0 = llvm.urem %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 678 : index} {
    %0 = llvm.urem %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 679 : index} {
    %0 = llvm.udiv %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 680 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 681 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 682 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 683 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 684 : index} {
    %0 = llvm.urem %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 685 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 686 : index} {
    %0 = llvm.udiv %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 687 : index} {
    %0 = llvm.urem %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 688 : index} {
    %0 = llvm.urem %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 689 : index} {
    %0 = llvm.urem %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 690 : index} {
    %0 = llvm.udiv %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 691 : index} {
    %0 = llvm.urem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 692 : index} {
    %0 = llvm.sdiv %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 693 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 694 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 695 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 696 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 697 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 698 : index} {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 699 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 700 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 701 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 702 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 703 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 704 : index} {
    %0 = llvm.sdiv %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 705 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 706 : index} {
    %0 = llvm.udiv %arg1, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 707 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 708 : index} {
    %0 = llvm.udiv %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 709 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 710 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 711 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 712 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 713 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 714 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 715 : index} {
    %0 = llvm.udiv %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 716 : index} {
    %0 = llvm.sdiv %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 717 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 718 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 719 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 720 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 721 : index} {
    %0 = llvm.udiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 722 : index} {
    %0 = llvm.mul %arg1, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 723 : index} {
    %0 = llvm.mul %arg1, %arg2 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 724 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 725 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 726 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 727 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 728 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 729 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 730 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 731 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 732 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 733 : index} {
    %0 = llvm.mul %arg1, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 734 : index} {
    %0 = llvm.mul %arg1, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 735 : index} {
    %0 = llvm.mul %arg1, %arg2 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 736 : index} {
    %0 = llvm.sdiv %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 737 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 738 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 739 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 740 : index} {
    %0 = llvm.sdiv %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 741 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 742 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 743 : index} {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 744 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 745 : index} {
    %0 = llvm.sdiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 746 : index} {
    %0 = llvm.mul %arg1, %arg2 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 747 : index} {
    %0 = llvm.sdiv %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 748 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 749 : index} {
    %0 = llvm.sdiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 750 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 751 : index} {
    %0 = llvm.sdiv %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 752 : index} {
    %0 = llvm.ashr %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 753 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 754 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 755 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 756 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 757 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 758 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 759 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 760 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 761 : index} {
    %0 = llvm.mul %arg1, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 762 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 763 : index} {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 764 : index} {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 765 : index} {
    %0 = llvm.ashr %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 766 : index} {
    %0 = llvm.mul %arg1, %arg2 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 767 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 768 : index} {
    %0 = llvm.mul %arg1, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 769 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 770 : index} {
    %0 = llvm.mul %arg1, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 771 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 772 : index} {
    %0 = llvm.ashr %arg1, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 773 : index} {
    %0 = llvm.mul %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 774 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 775 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 776 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 777 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 778 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 779 : index} {
    %0 = llvm.mul %arg1, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 780 : index} {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 781 : index} {
    %0 = llvm.mul %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 782 : index} {
    %0 = llvm.lshr %arg1, %arg1 {isExactFlag} : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 783 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 784 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 785 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 786 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 787 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 788 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 789 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 790 : index} {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 791 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 792 : index} {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 793 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 794 : index} {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 795 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 796 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 797 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 798 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 799 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 800 : index} {
    %0 = llvm.ashr %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 801 : index} {
    %0 = llvm.ashr %arg1, %arg1 : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 802 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 803 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 804 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 805 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 806 : index} {
    %0 = llvm.lshr %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 807 : index} {
    %0 = llvm.ashr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 808 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 809 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 810 : index} {
    %0 = llvm.lshr %arg0, %arg1 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 811 : index} {
    %0 = llvm.ashr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 812 : index} {
    %0 = llvm.shl %arg1, %arg2 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 813 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 814 : index} {
    %0 = llvm.lshr %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 815 : index} {
    %0 = llvm.shl %arg1, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 816 : index} {
    %0 = llvm.lshr %arg1, %arg2 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 817 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 818 : index} {
    %0 = llvm.shl %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 819 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 820 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 821 : index} {
    %0 = llvm.lshr %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 822 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 823 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 824 : index} {
    %0 = llvm.shl %arg1, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 825 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 826 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 827 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 828 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 829 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 830 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 831 : index} {
    %0 = llvm.lshr %arg1, %arg0 : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 832 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 833 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 834 : index} {
    %0 = llvm.lshr %arg1, %arg0 {isExactFlag} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 835 : index} {
    %0 = llvm.shl %arg1, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 836 : index} {
    %0 = llvm.shl %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 837 : index} {
    %0 = llvm.lshr %arg1, %arg2 {isExactFlag} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 838 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 839 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 840 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 841 : index} {
    %0 = llvm.lshr %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 842 : index} {
    %0 = llvm.sub %arg1, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 843 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 844 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 845 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 846 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 847 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 848 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 849 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 850 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 851 : index} {
    %0 = llvm.shl %arg1, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 852 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 853 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 854 : index} {
    %0 = llvm.sub %arg1, %arg2 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 855 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 856 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 857 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 858 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 859 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 860 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 861 : index} {
    %0 = llvm.shl %arg1, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 862 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 863 : index} {
    %0 = llvm.sub %arg1, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 864 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 865 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 866 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 867 : index} {
    %0 = llvm.shl %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 868 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 869 : index} {
    %0 = llvm.shl %arg1, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 870 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 871 : index} {
    %0 = llvm.shl %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 872 : index} {
    %0 = llvm.add %arg1, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 873 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 874 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 875 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 876 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 877 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 878 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 879 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 880 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 881 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 882 : index} {
    %0 = llvm.add %arg1, %arg2 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 883 : index} {
    %0 = llvm.add %arg1, %arg2 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 884 : index} {
    %0 = llvm.add %arg1, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 885 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 886 : index} {
    %0 = llvm.sub %arg1, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 887 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 888 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 889 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 890 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 891 : index} {
    %0 = llvm.sub %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 892 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 893 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.icmp "uge" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 894 : index} {
    %0 = llvm.sub %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 895 : index} {
    %0 = llvm.add %arg1, %arg1 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 896 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 897 : index} {
    %0 = llvm.add %arg0, %arg1 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 898 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 899 : index} {
    %0 = llvm.sub %arg0, %arg1 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 900 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 901 : index} {
    %0 = llvm.sub %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 902 : index} {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 903 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 904 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 905 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 906 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 907 : index} {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 908 : index} {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 909 : index} {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 910 : index} {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 911 : index} {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 912 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 913 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 914 : index} {
    %0 = llvm.xor %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 915 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 916 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 917 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<none>} : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 918 : index} {
    %0 = llvm.xor %arg1, %arg2 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 919 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 920 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 921 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 922 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 923 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 924 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 925 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 926 : index} {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 927 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 928 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 929 : index} {
    %0 = llvm.add %arg1, %arg0 {overflowFlags = #llvm.overflow<nsw>} : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 930 : index} {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 931 : index} {
    %0 = llvm.add %arg0, %arg0 {overflowFlags = #llvm.overflow<nuw>} : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 932 : index} {
    %0 = llvm.or %arg1, %arg1 {isDisjointFlag} : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 933 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 934 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 935 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 936 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 937 : index} {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 938 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 939 : index} {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 940 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 941 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 942 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 943 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 944 : index} {
    %0 = llvm.or %arg1, %arg1 {isDisjointFlag} : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 945 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 946 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 947 : index} {
    %0 = llvm.xor %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 948 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 949 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 950 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 951 : index} {
    %0 = llvm.or %arg1, %arg0 {isDisjointFlag} : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 952 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 953 : index} {
    %0 = llvm.or %arg1, %arg0 {isDisjointFlag} : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 954 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 955 : index} {
    %0 = llvm.or %arg0, %arg1 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 956 : index} {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 957 : index} {
    %0 = llvm.or %arg0, %arg1 {isDisjointFlag} : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 958 : index} {
    %0 = llvm.or %arg1, %arg2 {isDisjointFlag} : i64
    %1 = llvm.udiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 959 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 960 : index} {
    %0 = llvm.or %arg0, %arg0 {isDisjointFlag} : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 961 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i64 attributes {seed = 962 : index} {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 963 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.srem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 964 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 965 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<none>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 966 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 967 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 968 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 969 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 970 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.ashr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 971 : index} {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.or %arg0, %0 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 972 : index} {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.urem %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 973 : index} {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.icmp "sle" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 974 : index} {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.select %arg0, %0, %arg2 : i1, i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 975 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.sub %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 976 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 977 : index} {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 978 : index} {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.xor %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 979 : index} {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 980 : index} {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.srem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 981 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.urem %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 982 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.shl %arg0, %0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 983 : index} {
    %0 = llvm.and %arg1, %arg1 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 984 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.mul %arg0, %0 {overflowFlags = #llvm.overflow<nuw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 985 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.lshr %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 986 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 987 : index} {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.ashr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 988 : index} {
    %0 = llvm.and %arg0, %arg1 : i64
    %1 = llvm.udiv %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 989 : index} {
    %0 = llvm.and %arg1, %arg2 : i64
    %1 = llvm.lshr %arg0, %0 {isExactFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 990 : index} {
    %0 = llvm.and %arg1, %arg0 : i64
    %1 = llvm.add %arg0, %0 {overflowFlags = #llvm.overflow<nsw>} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 991 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 992 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.trunc %0 {overflowFlags = #llvm.overflow<nsw>} : i1 to i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 993 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 994 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 995 : index} {
    %0 = llvm.mul %arg0, %arg0 {overflowFlags = #llvm.overflow<nsw, nuw>} : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 996 : index} {
    %0 = llvm.udiv %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.ashr %0, %arg0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 997 : index} {
    %0 = llvm.sdiv %arg0, %arg1 {isExactFlag} : i64
    %1 = llvm.or %0, %arg2 {isDisjointFlag} : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 998 : index} {
    %0 = llvm.trunc %arg0 {overflowFlags = #llvm.overflow<nuw>} : i1 to i64
    %1 = llvm.and %0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 999 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.select %0, %arg0, %arg1 : i1, i64
    return %1 : i64
  }
}
// -----