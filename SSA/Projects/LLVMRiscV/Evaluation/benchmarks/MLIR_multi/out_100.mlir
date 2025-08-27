module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 0 : index} {
    %0 = llvm.sext %arg0 : i1 to i64
    %1 = llvm.udiv %0, %0 : i64
    %2 = llvm.and %0, %1 : i64
    %3 = llvm.trunc %2 : i64 to i1
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 1 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 2 : index} {
    return %arg0 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 4 : index} {
    %0 = llvm.mul %arg0, %arg1 : i64
    %1 = llvm.srem %0, %arg0 : i64
    %2 = llvm.srem %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 5 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 6 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 7 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 8 : index} {
    return %arg0 : i32
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
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 10 : index} {
    %0 = llvm.sdiv %arg1, %arg0 : i64
    %1 = llvm.icmp "sle" %arg1, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    %3 = llvm.icmp "ne" %arg0, %2 : i64
    return %3 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 11 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    %1 = llvm.sdiv %0, %arg1 : i64
    %2 = llvm.lshr %arg1, %arg1 : i64
    %3 = llvm.ashr %1, %2 : i64
    %4 = llvm.icmp "sge" %3, %arg0 : i64
    return %4 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 12 : index} {
    %0 = llvm.and %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 13 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 14 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 15 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 16 : index} {
    %0 = llvm.trunc %arg0 : i64 to i1
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 17 : index} {
    %0 = llvm.trunc %arg0 overflow<nsw> : i64 to i1
    %1 = llvm.sext %0 : i1 to i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 18 : index} {
    %0 = llvm.or %arg1, %arg1 : i64
    %1 = llvm.and %arg0, %0 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 19 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 20 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 21 : index} {
    %0 = llvm.trunc %arg0 : i64 to i1
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 22 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 23 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 24 : index} {
    %0 = llvm.icmp "sge" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 attributes {seed = 25 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.mul %arg0, %0 : i64
    %2 = llvm.ashr %arg0, %1 : i64
    %3 = llvm.icmp "slt" %2, %2 : i64
    %4 = llvm.sext %3 : i1 to i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 26 : index} {
    %0 = llvm.lshr %arg0, %arg0 : i64
    %1 = llvm.sext %arg1 : i1 to i64
    %2 = llvm.sdiv %0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 27 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg0 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.icmp "sgt" %1, %arg0 : i64
    return %2 : i1
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
  func.func @main(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 attributes {seed = 29 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.sdiv %0, %0 : i64
    %2 = llvm.srem %0, %1 : i64
    %3 = llvm.sub %1, %2 overflow<nsw, nuw> : i64
    %4 = llvm.ashr %1, %3 : i64
    %5 = llvm.sdiv %4, %2 : i64
    %6 = llvm.select %arg0, %1, %5 : i1, i64
    %7 = llvm.add %arg1, %6 overflow<nsw> : i64
    %8 = llvm.add %7, %arg2 overflow<nsw> : i64
    %9 = llvm.xor %6, %8 : i64
    return %9 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 30 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i1) -> i64 attributes {seed = 31 : index} {
    %0 = llvm.xor %arg0, %arg1 : i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.shl %1, %0 overflow<nuw> : i64
    %3 = llvm.xor %2, %2 : i64
    %4 = llvm.mul %0, %3 overflow<nuw> : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 32 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 33 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 34 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 35 : index} {
    %0 = llvm.icmp "slt" %arg0, %arg0 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 36 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 37 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 38 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 39 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 40 : index} {
    %0 = llvm.mul %arg0, %arg0 overflow<nuw> : i64
    %1 = llvm.urem %0, %arg1 : i64
    return %1 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 41 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 42 : index} {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 43 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 44 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 45 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 46 : index} {
    %0 = llvm.udiv %arg0, %arg1 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 47 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 48 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 49 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %0, %0 : i1, i64
    %2 = llvm.trunc %1 overflow<nsw> : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 50 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 51 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 52 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 53 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 54 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 55 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 56 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 57 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 attributes {seed = 58 : index} {
    %0 = llvm.or %arg1, %arg2 : i64
    %1 = llvm.urem %arg0, %0 : i64
    %2 = llvm.or %1, %0 : i64
    %3 = llvm.icmp "slt" %2, %arg0 : i64
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.icmp "ne" %2, %4 : i64
    return %5 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 59 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i64 attributes {seed = 60 : index} {
    %0 = llvm.zext %arg0 : i1 to i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 61 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 62 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 63 : index} {
    %0 = llvm.xor %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 64 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 65 : index} {
    %0 = llvm.mul %arg0, %arg0 overflow<nsw, nuw> : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 66 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 67 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 68 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 69 : index} {
    %0 = llvm.trunc %arg0 : i64 to i1
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 70 : index} {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw> : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 71 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 72 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 73 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 74 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 75 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 76 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1, %arg2: i64) -> i1 attributes {seed = 77 : index} {
    %0 = llvm.select %arg1, %arg2, %arg0 : i1, i64
    %1 = llvm.mul %0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %1 : i64
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 78 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 79 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 80 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 81 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 82 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sub %0, %arg1 : i64
    %2 = llvm.and %1, %arg1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 83 : index} {
    %0 = llvm.or %arg1, %arg0 : i64
    %1 = llvm.mul %arg0, %0 overflow<nsw, nuw> : i64
    %2 = llvm.or %arg0, %1 : i64
    return %2 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 84 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 85 : index} {
    return %arg0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i64 attributes {seed = 86 : index} {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i64
    %2 = llvm.ashr %1, %arg0 : i64
    %3 = llvm.urem %2, %2 : i64
    %4 = llvm.ashr %3, %1 : i64
    return %4 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i64) -> i1 attributes {seed = 87 : index} {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i64
    return %0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i64, %arg1: i1) -> i64 attributes {seed = 88 : index} {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.mul %arg0, %0 overflow<nuw> : i64
    %2 = llvm.xor %arg0, %1 : i64
    %3 = llvm.or %arg0, %2 : i64
    return %3 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 89 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    return %0 : i64
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 90 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 91 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1, %arg1: i64) -> i1 attributes {seed = 92 : index} {
    %0 = llvm.select %arg0, %arg1, %arg1 : i1, i64
    %1 = llvm.ashr %0, %arg1 : i64
    %2 = llvm.trunc %1 overflow<nsw> : i64 to i1
    return %2 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 93 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 94 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.trunc %0 : i64 to i1
    return %1 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 95 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 96 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i1) -> i1 attributes {seed = 97 : index} {
    return %arg0 : i1
  }
}
// -----
module {
  func.func @main(%arg0: i32) -> i32 attributes {seed = 98 : index} {
    return %arg0 : i32
  }
}
// -----
module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 99 : index} {
    %0 = llvm.or %arg0, %arg0 : i64
    %1 = llvm.sub %0, %arg0 : i64
    %2 = llvm.srem %1, %1 : i64
    %3 = llvm.lshr %arg0, %2 : i64
    return %3 : i64
  }
}
// -----