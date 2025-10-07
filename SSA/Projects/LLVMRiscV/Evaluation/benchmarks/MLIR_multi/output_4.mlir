module {
  func.func @main(: i64) -> i64 {
     = arith.constant -39 : i64
     = arith.constant -32 : i64
     = arith.constant -9 : i64
     = arith.constant -37 : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 35 : i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -2 : i64
     = arith.constant -26 : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -28 : i64
     = arith.constant 44 : i64
     = arith.constant -26 : i64
     = arith.constant -19 : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 38 : i64
     = arith.constant 18 : i64
     = arith.constant -36 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -36 : i64
     = arith.constant false
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant -46 : i64
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 13 : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 48 : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -10 : i64
     = llvm.trunc  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -1 : i64
     = arith.constant false
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -14 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 22 : i64
     = arith.constant 37 : i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -13 : i64
     = arith.constant -39 : i64
     = arith.constant -6 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 36 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -41 : i64
     = arith.constant 17 : i64
     = arith.constant -20 : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 16 : i64
     = arith.constant -8 : i64
     = arith.constant 5 : i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -43 : i64
     = arith.constant 21 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 41 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant true
     = arith.constant -7 : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -40 : i64
     = arith.constant 38 : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 2 : i64
     = arith.constant -14 : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 45 : i64
     = arith.constant -47 : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant false
     = llvm.urem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = llvm.srem ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -27 : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 43 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 28 : i64
     = arith.constant true
     = arith.constant false
     = arith.constant 11 : i64
     = arith.constant 44 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 11 : i64
     = arith.constant 20 : i64
     = arith.constant false
     = llvm.srem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -29 : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.sdiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -20 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -50 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 43 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 30 : i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -13 : i64
     = arith.constant -33 : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 35 : i64
     = arith.constant 23 : i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 26 : i64
     = arith.constant -15 : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 33 : i64
     = arith.constant 26 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -3 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = llvm.srem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 1 : i64
     = arith.constant 36 : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 0 : i64
     = arith.constant -19 : i64
     = arith.constant -45 : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -2 : i64
     = arith.constant -3 : i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 29 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant 1 : i64
     = arith.constant -30 : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -46 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -26 : i64
     = arith.constant -3 : i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 37 : i64
     = llvm.and ,  : i64
     = llvm.lshr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant 42 : i64
     = arith.constant -16 : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 6 : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 28 : i64
     = arith.constant -25 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 10 : i64
     = arith.constant -4 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 46 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 9 : i64
     = arith.constant -37 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -29 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 23 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 17 : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = arith.constant -30 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -40 : i64
     = arith.constant -8 : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -27 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 35 : i64
     = arith.constant true
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 45 : i64
     = arith.constant -25 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 49 : i64
     = arith.constant 47 : i64
     = arith.constant true
     = arith.constant -32 : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = arith.constant true
     = arith.constant -38 : i64
     = arith.constant 48 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant -37 : i64
     = arith.constant -3 : i64
     = arith.constant 10 : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = arith.constant -18 : i64
     = arith.constant -31 : i64
     = arith.constant 6 : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -33 : i64
     = arith.constant 9 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -27 : i64
     = arith.constant 41 : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -28 : i64
     = llvm.or ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 48 : i64
     = arith.constant 1 : i64
     = arith.constant 36 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -8 : i64
     = arith.constant 40 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant true
     = arith.constant -23 : i64
     = arith.constant 39 : i64
     = llvm.srem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -22 : i64
     = llvm.srem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 22 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -33 : i64
     = arith.constant -37 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant -29 : i64
     = arith.constant -21 : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 20 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant -36 : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 13 : i64
     = arith.constant -26 : i64
     = arith.constant -44 : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 10 : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 46 : i64
     = arith.constant -14 : i64
     = arith.constant true
     = arith.constant 22 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant 33 : i64
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant -49 : i64
     = arith.constant 7 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -27 : i64
     = arith.constant -33 : i64
     = arith.constant 23 : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 35 : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 39 : i64
     = arith.constant 36 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -25 : i64
     = arith.constant -3 : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 20 : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 6 : i64
     = arith.constant -49 : i64
     = arith.constant 37 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 37 : i64
     = arith.constant -1 : i64
     = arith.constant 50 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 45 : i64
     = arith.constant false
     = llvm.sdiv ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "eq" ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -36 : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -42 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -4 : i64
     = arith.constant 46 : i64
     = arith.constant 16 : i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 6 : i64
     = arith.constant -35 : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -24 : i64
     = arith.constant 8 : i64
     = arith.constant -11 : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i1) -> i1 {
     = llvm.and ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -23 : i64
     = arith.constant 29 : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 29 : i64
     = arith.constant 3 : i64
     = arith.constant 16 : i64
     = arith.constant -18 : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = arith.constant 12 : i64
     = arith.constant -10 : i64
     = llvm.lshr ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant true
     = arith.constant 15 : i64
     = llvm.ashr ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 36 : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant -8 : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant 0 : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 14 : i64
     = arith.constant 23 : i64
     = arith.constant -30 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 23 : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 42 : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant 8 : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 35 : i64
     = arith.constant 19 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 4 : i64
     = arith.constant 45 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -6 : i64
     = arith.constant 4 : i64
     = arith.constant 6 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i1) -> i1 {
     = arith.constant 23 : i64
     = llvm.sext  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -45 : i64
     = arith.constant -32 : i64
     = arith.constant -12 : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -45 : i64
     = arith.constant -22 : i64
     = arith.constant -40 : i64
     = arith.constant 2 : i64
     = arith.constant -15 : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -28 : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 6 : i64
     = arith.constant 42 : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant true
     = llvm.srem ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -44 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 14 : i64
     = arith.constant true
     = arith.constant 11 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 29 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 48 : i64
     = arith.constant 20 : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 41 : i64
     = arith.constant 49 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 1 : i64
     = arith.constant 20 : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -22 : i64
     = arith.constant -43 : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 39 : i64
     = arith.constant -25 : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 37 : i64
     = arith.constant 20 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 20 : i64
     = arith.constant 29 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant -42 : i64
     = arith.constant -11 : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 30 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 19 : i64
     = arith.constant 47 : i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 30 : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -3 : i64
     = arith.constant -16 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 6 : i64
     = arith.constant 15 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant -22 : i64
     = arith.constant 50 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -14 : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -15 : i64
     = arith.constant 10 : i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -11 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 21 : i64
     = arith.constant -45 : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 1 : i64
     = arith.constant 19 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -12 : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant true
     = llvm.sdiv ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 16 : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = arith.constant 36 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = llvm.ashr ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 42 : i64
     = arith.constant false
     = arith.constant -23 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -33 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -14 : i64
     = arith.constant 23 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 15 : i64
     = arith.constant -14 : i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant false
     = arith.constant -23 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 3 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -49 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -13 : i64
     = arith.constant 23 : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -44 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant -40 : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 40 : i64
     = arith.constant 0 : i64
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 21 : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -4 : i64
     = arith.constant -42 : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 1 : i64
     = arith.constant 27 : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.or ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant -15 : i64
     = llvm.srem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -6 : i64
     = arith.constant 44 : i64
     = arith.constant -3 : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -46 : i64
     = arith.constant 46 : i64
     = arith.constant -37 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = llvm.and ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -46 : i64
     = arith.constant 17 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = arith.constant 10 : i64
     = llvm.or ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.lshr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant 13 : i64
     = arith.constant -44 : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -4 : i64
     = arith.constant -38 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -2 : i64
     = arith.constant -40 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -19 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant -46 : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 44 : i64
     = arith.constant -18 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 5 : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -8 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 10 : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 16 : i64
     = arith.constant 8 : i64
     = arith.constant -39 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -44 : i64
     = arith.constant true
     = arith.constant 1 : i64
     = arith.constant -28 : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 45 : i64
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant false
     = arith.constant 9 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -6 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -48 : i64
     = arith.constant -17 : i64
     = arith.constant 1 : i64
     = arith.constant 9 : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 48 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -26 : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -9 : i64
     = arith.constant 14 : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -22 : i64
     = arith.constant 47 : i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 24 : i64
     = arith.constant -49 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -7 : i64
     = arith.constant 27 : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -16 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.urem ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i64 {
     = arith.constant 31 : i64
     = llvm.lshr ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 18 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 10 : i64
     = arith.constant -26 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -12 : i64
     = arith.constant 49 : i64
     = arith.constant 13 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -50 : i64
     = arith.constant -2 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 41 : i64
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant true
     = arith.constant 26 : i64
     = arith.constant 32 : i64
     = llvm.select , ,  : i1, i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 10 : i64
     = arith.constant -21 : i64
     = arith.constant -27 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant true
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 50 : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -44 : i64
     = arith.constant -46 : i64
     = arith.constant -38 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -49 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 48 : i64
     = arith.constant -3 : i64
     = llvm.srem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 27 : i64
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -19 : i64
     = arith.constant 0 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 5 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant true
     = arith.constant 3 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -16 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = arith.constant 11 : i64
     = arith.constant -33 : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 48 : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 17 : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 31 : i64
     = arith.constant 44 : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -36 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant true
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 34 : i64
     = arith.constant 36 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 27 : i64
     = arith.constant -33 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 4 : i64
     = arith.constant -29 : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -30 : i64
     = arith.constant -41 : i64
     = arith.constant -28 : i64
     = arith.constant -45 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 32 : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant 37 : i64
     = arith.constant 11 : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 43 : i64
     = llvm.lshr ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i1) -> i64 {
     = arith.constant 2 : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 33 : i64
     = arith.constant 47 : i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -8 : i64
     = arith.constant 27 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -1 : i64
     = arith.constant -40 : i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.select , ,  : i1, i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 42 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant -20 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 40 : i64
     = arith.constant 12 : i64
     = arith.constant -1 : i64
     = llvm.lshr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 20 : i64
     = arith.constant 44 : i64
     = arith.constant 42 : i64
     = arith.constant 29 : i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 23 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 23 : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant 10 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -25 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -19 : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 19 : i64
     = arith.constant 2 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 32 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -18 : i64
     = arith.constant -34 : i64
     = llvm.or ,  : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 13 : i64
     = arith.constant -36 : i64
     = arith.constant -30 : i64
     = arith.constant 33 : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 2 : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -8 : i64
     = arith.constant 43 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -20 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -30 : i64
     = arith.constant 41 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 18 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 0 : i64
     = arith.constant -32 : i64
     = arith.constant 48 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -45 : i64
     = arith.constant false
     = arith.constant 31 : i64
     = arith.constant 3 : i64
     = llvm.select , ,  : i1, i64
     = llvm.trunc  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -37 : i64
     = arith.constant false
     = arith.constant 18 : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant true
     = arith.constant -35 : i64
     = llvm.srem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 36 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant 27 : i64
     = arith.constant false
     = arith.constant -13 : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -40 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -28 : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 20 : i64
     = arith.constant 10 : i64
     = arith.constant 19 : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -37 : i64
     = arith.constant false
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.lshr ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant -47 : i64
     = arith.constant -32 : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 10 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 29 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 0 : i64
     = arith.constant 28 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -26 : i64
     = arith.constant -42 : i64
     = arith.constant 37 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -12 : i64
     = arith.constant 38 : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 32 : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 8 : i64
     = llvm.and ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -39 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 26 : i64
     = arith.constant -14 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 21 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant true
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -24 : i64
     = arith.constant 42 : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant -5 : i64
     = arith.constant -15 : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 14 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -20 : i64
     = arith.constant 25 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 22 : i64
     = arith.constant 6 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 3 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -18 : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -17 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = arith.constant 16 : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -13 : i64
     = arith.constant false
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -48 : i64
     = llvm.and ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -11 : i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 9 : i64
     = arith.constant 30 : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -3 : i64
     = llvm.and ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 17 : i64
     = arith.constant 25 : i64
     = arith.constant -44 : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -36 : i64
     = arith.constant -18 : i64
     = arith.constant -50 : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 44 : i64
     = arith.constant 36 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 13 : i64
     = arith.constant -6 : i64
     = arith.constant -8 : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.and ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -49 : i64
     = arith.constant 19 : i64
     = arith.constant -34 : i64
     = arith.constant -13 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 0 : i64
     = arith.constant 31 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant 5 : i64
     = arith.constant 2 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 38 : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -37 : i64
     = arith.constant -31 : i64
     = arith.constant 2 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -2 : i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 16 : i64
     = arith.constant -36 : i64
     = arith.constant 44 : i64
     = arith.constant -12 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -46 : i64
     = arith.constant -48 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 39 : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 0 : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -8 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 44 : i64
     = arith.constant 18 : i64
     = arith.constant true
     = arith.constant -8 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i1) -> i64 {
     = llvm.trunc  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -40 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -11 : i64
     = arith.constant 46 : i64
     = arith.constant -47 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -42 : i64
     = arith.constant 10 : i64
     = arith.constant 48 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 29 : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 22 : i64
     = arith.constant 49 : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = arith.constant 50 : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -40 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant -32 : i64
     = arith.constant 29 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -8 : i64
     = arith.constant 10 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -32 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 23 : i64
     = arith.constant -19 : i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -46 : i64
     = arith.constant 23 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.srem ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 28 : i64
     = arith.constant 39 : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 12 : i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -3 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -14 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -48 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -41 : i64
     = arith.constant -31 : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 10 : i64
     = arith.constant 45 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 45 : i64
     = arith.constant -24 : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 34 : i64
     = arith.constant -20 : i64
     = arith.constant -36 : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -45 : i64
     = arith.constant -17 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.and ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 30 : i64
     = arith.constant -20 : i64
     = arith.constant -5 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -11 : i64
     = arith.constant -8 : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 15 : i64
     = arith.constant false
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -49 : i64
     = arith.constant -3 : i64
     = arith.constant 36 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -4 : i64
     = arith.constant -29 : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 30 : i64
     = arith.constant -12 : i64
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 32 : i64
     = arith.constant 48 : i64
     = arith.constant -46 : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 6 : i64
     = arith.constant 23 : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -16 : i64
     = arith.constant -30 : i64
     = arith.constant -46 : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -47 : i64
     = arith.constant 20 : i64
     = arith.constant 50 : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 36 : i64
     = arith.constant 14 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 33 : i64
     = arith.constant -3 : i64
     = arith.constant 44 : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 43 : i64
     = arith.constant -3 : i64
     = arith.constant 39 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 8 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = arith.constant 42 : i64
     = llvm.or ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 5 : i64
     = arith.constant 47 : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 14 : i64
     = arith.constant 34 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -6 : i64
     = arith.constant 45 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 33 : i64
     = arith.constant -1 : i64
     = arith.constant -26 : i64
     = arith.constant -27 : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant 31 : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -28 : i64
     = arith.constant -1 : i64
     = arith.constant -27 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 25 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 9 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant 50 : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -46 : i64
     = arith.constant -45 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -17 : i64
     = arith.constant -45 : i64
     = arith.constant 24 : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 9 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 25 : i64
     = arith.constant -29 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -24 : i64
     = arith.constant 33 : i64
     = arith.constant -12 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 50 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 49 : i64
     = arith.constant 3 : i64
     = arith.constant -10 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -27 : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 7 : i64
     = arith.constant 31 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -16 : i64
     = arith.constant -21 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant true
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -14 : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -11 : i64
     = arith.constant -8 : i64
     = arith.constant -26 : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -27 : i64
     = arith.constant -26 : i64
     = arith.constant 10 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 25 : i64
     = arith.constant 43 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant 8 : i64
     = arith.constant false
     = arith.constant 13 : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -4 : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 26 : i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 4 : i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = arith.constant 33 : i64
     = llvm.and ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -37 : i64
     = arith.constant 49 : i64
     = arith.constant 21 : i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 11 : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -36 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 3 : i64
     = arith.constant 8 : i64
     = arith.constant -9 : i64
     = arith.constant 21 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -2 : i64
     = arith.constant -40 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 21 : i64
     = arith.constant -39 : i64
     = arith.constant 40 : i64
     = arith.constant -5 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -10 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -48 : i64
     = arith.constant -8 : i64
     = arith.constant 50 : i64
     = arith.constant -28 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 5 : i64
     = arith.constant 33 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 23 : i64
     = arith.constant 12 : i64
     = arith.constant -28 : i64
     = arith.constant -3 : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 44 : i64
     = arith.constant -27 : i64
     = arith.constant -31 : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -44 : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 25 : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 44 : i64
     = arith.constant -7 : i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant false
     = arith.constant -10 : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 47 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 0 : i64
     = arith.constant -39 : i64
     = arith.constant 19 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -37 : i64
     = arith.constant -48 : i64
     = arith.constant true
     = arith.constant -46 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -40 : i64
     = arith.constant -44 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 50 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 47 : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 23 : i64
     = arith.constant 50 : i64
     = arith.constant -33 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -44 : i64
     = arith.constant 26 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -34 : i64
     = arith.constant -16 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -18 : i64
     = arith.constant 0 : i64
     = arith.constant 5 : i64
     = arith.constant -32 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -29 : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = arith.constant 46 : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -32 : i64
     = arith.constant 34 : i64
     = arith.constant 42 : i64
     = arith.constant 26 : i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 4 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.srem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 46 : i64
     = arith.constant 4 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 9 : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 41 : i64
     = arith.constant -30 : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 48 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -19 : i64
     = arith.constant -34 : i64
     = llvm.xor ,  : i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -36 : i64
     = arith.constant -21 : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant -26 : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 30 : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 15 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -20 : i64
     = arith.constant -1 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant -15 : i64
     = arith.constant -27 : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant -26 : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 6 : i64
     = arith.constant 49 : i64
     = llvm.lshr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant false
     = arith.constant true
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -45 : i64
     = arith.constant -10 : i64
     = llvm.lshr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant 9 : i64
     = llvm.and ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -10 : i64
     = llvm.and ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = arith.constant -44 : i64
     = llvm.sdiv ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 17 : i64
     = arith.constant 12 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -38 : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 16 : i64
     = arith.constant -8 : i64
     = arith.constant 21 : i64
     = arith.constant 0 : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 18 : i64
     = arith.constant -33 : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -7 : i64
     = arith.constant -42 : i64
     = arith.constant -2 : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 2 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 45 : i64
     = arith.constant -43 : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -46 : i64
     = arith.constant 0 : i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 14 : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -29 : i64
     = arith.constant 3 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -48 : i64
     = arith.constant -25 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 37 : i64
     = arith.constant 31 : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 48 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -12 : i64
     = arith.constant -42 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -43 : i64
     = arith.constant 46 : i64
     = llvm.srem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -40 : i64
     = arith.constant 43 : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -36 : i64
     = arith.constant 22 : i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 20 : i64
     = arith.constant 8 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -11 : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -34 : i64
     = arith.constant -43 : i64
     = arith.constant 48 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.srem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -5 : i64
     = arith.constant true
     = arith.constant -40 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 17 : i64
     = arith.constant 8 : i64
     = arith.constant -49 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 27 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -46 : i64
     = arith.constant -24 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -44 : i64
     = arith.constant 25 : i64
     = arith.constant 14 : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -2 : i64
     = arith.constant 28 : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -47 : i64
     = arith.constant -18 : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -48 : i64
     = arith.constant -36 : i64
     = arith.constant 28 : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -2 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 8 : i64
     = arith.constant 11 : i64
     = arith.constant -33 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 45 : i64
     = arith.constant -39 : i64
     = arith.constant -33 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -50 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -9 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -23 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -30 : i64
     = arith.constant -11 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 28 : i64
     = arith.constant -19 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -21 : i64
     = arith.constant 13 : i64
     = arith.constant 42 : i64
     = arith.constant -2 : i64
     = arith.constant -5 : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant true
     = llvm.select , ,  : i1, i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -32 : i64
     = arith.constant -6 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 48 : i64
     = arith.constant 25 : i64
     = arith.constant -20 : i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -18 : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 44 : i64
     = llvm.zext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -1 : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -19 : i64
     = arith.constant -39 : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant 1 : i64
     = arith.constant -39 : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 4 : i64
     = arith.constant 22 : i64
     = arith.constant 45 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i64 {
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 24 : i64
     = arith.constant 46 : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -37 : i64
     = arith.constant -2 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant -20 : i64
     = arith.constant 30 : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -44 : i64
     = arith.constant 35 : i64
     = arith.constant 27 : i64
     = llvm.srem ,  : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -45 : i64
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant -18 : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -31 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 20 : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 11 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -29 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 45 : i64
     = arith.constant 20 : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 5 : i64
     = arith.constant -3 : i64
     = arith.constant -33 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.and ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -20 : i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -5 : i64
     = arith.constant true
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 24 : i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -47 : i64
     = arith.constant -41 : i64
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant true
     = arith.constant -14 : i64
     = arith.constant 32 : i64
     = llvm.srem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -49 : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -14 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 24 : i64
     = arith.constant 19 : i64
     = arith.constant 2 : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 49 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i64 {
     = llvm.and ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -12 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -11 : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -42 : i64
     = arith.constant true
     = arith.constant false
     = arith.constant 41 : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -29 : i64
     = arith.constant -41 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 6 : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 11 : i64
     = arith.constant 45 : i64
     = arith.constant -35 : i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -17 : i64
     = arith.constant -33 : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = arith.constant 29 : i64
     = llvm.ashr ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 3 : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 3 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -24 : i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 19 : i64
     = arith.constant 8 : i64
     = arith.constant 49 : i64
     = llvm.and ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -35 : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 26 : i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 28 : i64
     = arith.constant 31 : i64
     = arith.constant -33 : i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 24 : i64
     = arith.constant 13 : i64
     = arith.constant -45 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -13 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -7 : i64
     = arith.constant -35 : i64
     = arith.constant 10 : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -15 : i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -37 : i64
     = arith.constant 40 : i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 31 : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant 41 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant true
     = arith.constant -32 : i64
     = arith.constant 21 : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 14 : i64
     = arith.constant 50 : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = arith.constant 11 : i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -39 : i64
     = arith.constant true
     = arith.constant 45 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -27 : i64
     = arith.constant 27 : i64
     = arith.constant -42 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -7 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 4 : i64
     = arith.constant -22 : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -25 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -37 : i64
     = arith.constant -16 : i64
     = arith.constant 31 : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -44 : i64
     = arith.constant 33 : i64
     = arith.constant -36 : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -36 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 24 : i64
     = arith.constant 5 : i64
     = arith.constant -11 : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 12 : i64
     = arith.constant true
     = arith.constant -35 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant -37 : i64
     = arith.constant 48 : i64
     = llvm.urem ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -45 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -43 : i64
     = arith.constant -9 : i64
     = arith.constant 12 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant 30 : i64
     = arith.constant -43 : i64
     = arith.constant -26 : i64
     = llvm.and ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 42 : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant -1 : i64
     = arith.constant -33 : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -27 : i64
     = arith.constant -10 : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant true
     = arith.constant 25 : i64
     = arith.constant 29 : i64
     = llvm.urem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -16 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 35 : i64
     = arith.constant 29 : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -26 : i64
     = arith.constant -1 : i64
     = arith.constant -3 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 6 : i64
     = arith.constant -27 : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -3 : i64
     = arith.constant 27 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -13 : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 24 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -9 : i64
     = arith.constant -33 : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 15 : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 15 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 7 : i64
     = arith.constant 24 : i64
     = llvm.or ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 4 : i64
     = arith.constant -38 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -2 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -32 : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -16 : i64
     = arith.constant -42 : i64
     = arith.constant -41 : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = arith.constant -50 : i64
     = arith.constant 36 : i64
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 22 : i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant -41 : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -26 : i64
     = arith.constant -50 : i64
     = arith.constant -36 : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -5 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -19 : i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant 28 : i64
     = arith.constant -42 : i64
     = llvm.srem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 30 : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 27 : i64
     = arith.constant false
     = arith.constant 33 : i64
     = arith.constant 34 : i64
     = llvm.select , ,  : i1, i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 37 : i64
     = arith.constant -38 : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant 10 : i64
     = llvm.and ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -17 : i64
     = arith.constant 36 : i64
     = arith.constant 25 : i64
     = arith.constant 11 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -2 : i64
     = arith.constant 39 : i64
     = arith.constant -1 : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 13 : i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 45 : i64
     = arith.constant -18 : i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 6 : i64
     = llvm.urem ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -1 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 23 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant 17 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 47 : i64
     = llvm.or ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant true
     = arith.constant -37 : i64
     = arith.constant 18 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant true
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 36 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 49 : i64
     = arith.constant -20 : i64
     = arith.constant -10 : i64
     = llvm.lshr ,  : i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i1) -> i64 {
     = arith.constant 39 : i64
     = arith.constant -41 : i64
     = arith.constant -9 : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -43 : i64
     = arith.constant 14 : i64
     = arith.constant -11 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -13 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -19 : i64
     = arith.constant -9 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 17 : i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant true
     = arith.constant -48 : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -20 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 42 : i64
     = arith.constant 28 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 41 : i64
     = arith.constant false
     = arith.constant 23 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.urem ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -48 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 44 : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 8 : i64
     = arith.constant -41 : i64
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant false
     = arith.constant -41 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant -2 : i64
     = arith.constant -25 : i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -35 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -15 : i64
     = arith.constant 48 : i64
     = arith.constant 31 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant -7 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -28 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -22 : i64
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 17 : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 32 : i64
     = arith.constant 21 : i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -9 : i64
     = arith.constant true
     = arith.constant -3 : i64
     = arith.constant 36 : i64
     = llvm.xor ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -29 : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = llvm.or ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -36 : i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -2 : i64
     = arith.constant 13 : i64
     = arith.constant 5 : i64
     = arith.constant -34 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.and ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -19 : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 25 : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 37 : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant true
     = arith.constant 46 : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i1) -> i1 {
     = arith.constant -5 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -48 : i64
     = arith.constant -1 : i64
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant false
     = llvm.zext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 16 : i64
     = arith.constant -7 : i64
     = arith.constant 23 : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -39 : i64
     = arith.constant -29 : i64
     = llvm.or ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant true
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -10 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant -16 : i64
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -14 : i64
     = llvm.or ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 22 : i64
     = arith.constant -5 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 18 : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 26 : i64
     = arith.constant 41 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -23 : i64
     = arith.constant 18 : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.srem ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant -47 : i64
     = arith.constant 41 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 30 : i64
     = arith.constant 34 : i64
     = arith.constant 33 : i64
     = arith.constant -49 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 42 : i64
     = arith.constant -28 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant true
     = arith.constant 21 : i64
     = arith.constant -1 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -29 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 2 : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -1 : i64
     = arith.constant 12 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 38 : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.trunc  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -27 : i64
     = arith.constant -25 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 13 : i64
     = arith.constant -25 : i64
     = arith.constant 50 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 33 : i64
     = llvm.select , ,  : i1, i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 11 : i64
     = arith.constant -13 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 32 : i64
     = arith.constant 33 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -29 : i64
     = arith.constant -25 : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -30 : i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 11 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 3 : i64
     = arith.constant 45 : i64
     = llvm.ashr ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 7 : i64
     = arith.constant -19 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 4 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 48 : i64
     = llvm.sdiv ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant -5 : i64
     = arith.constant 32 : i64
     = arith.constant 10 : i64
     = arith.constant 4 : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 31 : i64
     = arith.constant 26 : i64
     = arith.constant -36 : i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 12 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 8 : i64
     = arith.constant -49 : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 10 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 50 : i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 45 : i64
     = arith.constant -35 : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 15 : i64
     = arith.constant -44 : i64
     = arith.constant -36 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -15 : i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant 6 : i64
     = llvm.srem ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant true
     = arith.constant -17 : i64
     = llvm.xor ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 34 : i64
     = arith.constant 43 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 5 : i64
     = llvm.and ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 17 : i64
     = arith.constant -11 : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i1, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 44 : i64
     = arith.constant 12 : i64
     = arith.constant -14 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -32 : i64
     = arith.constant -45 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.xor ,  : i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 0 : i64
     = arith.constant -26 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 41 : i64
     = arith.constant -28 : i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 25 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant 46 : i64
     = arith.constant -33 : i64
     = arith.constant 24 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -9 : i64
     = arith.constant -37 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant -12 : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 37 : i64
     = arith.constant -9 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ule" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 32 : i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 13 : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -21 : i64
     = arith.constant -43 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -12 : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 49 : i64
     = arith.constant 47 : i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 41 : i64
     = arith.constant 43 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 35 : i64
     = arith.constant -22 : i64
     = arith.constant -23 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant 40 : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -39 : i64
     = arith.constant -5 : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 41 : i64
     = arith.constant 0 : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = arith.constant 38 : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -36 : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = arith.constant -1 : i64
     = arith.constant -24 : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -10 : i64
     = arith.constant -47 : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -40 : i64
     = arith.constant -32 : i64
     = llvm.or ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 9 : i64
     = arith.constant -35 : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -37 : i64
     = llvm.lshr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -14 : i64
     = llvm.urem ,  : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 8 : i64
     = arith.constant 3 : i64
     = llvm.trunc  : i1 to i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.icmp "sge" ,  : i64
     = llvm.lshr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 28 : i64
     = arith.constant -15 : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 46 : i64
     = arith.constant 35 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -8 : i64
     = arith.constant 20 : i64
     = arith.constant -6 : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = arith.constant 2 : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 27 : i64
     = arith.constant -17 : i64
     = arith.constant 29 : i64
     = arith.constant -37 : i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -7 : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant 6 : i64
     = arith.constant -38 : i64
     = llvm.xor ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 24 : i64
     = arith.constant 27 : i64
     = arith.constant 50 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant 5 : i64
     = arith.constant -33 : i64
     = llvm.and ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 36 : i64
     = arith.constant -37 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -37 : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -32 : i64
     = llvm.xor ,  : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 41 : i64
     = arith.constant 26 : i64
     = arith.constant 0 : i64
     = llvm.lshr ,  : i64
     = llvm.srem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant -1 : i64
     = arith.constant -9 : i64
     = arith.constant false
     = arith.constant -42 : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 27 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 41 : i64
     = arith.constant -7 : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -23 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 43 : i64
     = arith.constant 25 : i64
     = arith.constant 26 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 50 : i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 28 : i64
     = arith.constant 40 : i64
     = arith.constant -40 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 2 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant -27 : i64
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -22 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 39 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.and ,  : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 15 : i64
     = arith.constant -40 : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.ashr ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 30 : i64
     = arith.constant 44 : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 8 : i64
     = llvm.sdiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 9 : i64
     = llvm.ashr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -29 : i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -1 : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant 38 : i64
     = arith.constant -7 : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 27 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant true
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 32 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 38 : i64
     = arith.constant -35 : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -35 : i64
     = arith.constant -29 : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 15 : i64
     = arith.constant -20 : i64
     = arith.constant 19 : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant false
     = arith.constant -6 : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -49 : i64
     = arith.constant 10 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 34 : i64
     = arith.constant -23 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.udiv ,  : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 29 : i64
     = arith.constant -13 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sle" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 13 : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -44 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 43 : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = arith.constant 10 : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -36 : i64
     = llvm.and ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -8 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 46 : i64
     = arith.constant 32 : i64
     = arith.constant 14 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = llvm.lshr ,  : i64
     = llvm.srem ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i1) -> i1 {
     = arith.constant 23 : i64
     = llvm.zext  : i1 to i64
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -11 : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 15 : i64
     = llvm.and ,  : i64
     = llvm.xor ,  : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 15 : i64
     = llvm.or ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 34 : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.urem ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -27 : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.udiv ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant 0 : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant false
     = arith.constant -14 : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = llvm.urem ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 50 : i64
     = arith.constant 9 : i64
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant -44 : i64
     = arith.constant 18 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -3 : i64
     = arith.constant -16 : i64
     = arith.constant -22 : i64
     = llvm.srem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 46 : i64
     = arith.constant 19 : i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant false
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i64 {
     = arith.constant -17 : i64
     = arith.constant -39 : i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant true
     = llvm.sext  : i1 to i64
     = llvm.or ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 43 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 21 : i64
     = arith.constant -4 : i64
     = arith.constant 2 : i64
     = arith.constant 18 : i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 37 : i64
     = arith.constant true
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = llvm.icmp "ult" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sext  : i1 to i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -12 : i64
     = arith.constant 2 : i64
     = llvm.udiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 49 : i64
     = arith.constant -11 : i64
     = llvm.and ,  : i64
     = llvm.or ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant 46 : i64
     = arith.constant false
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.and ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant false
     = arith.constant 34 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i64 {
     = llvm.lshr ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 47 : i64
     = arith.constant -41 : i64
     = arith.constant -27 : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i64 {
     = arith.constant -26 : i64
     = arith.constant 39 : i64
     = llvm.udiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 7 : i64
     = arith.constant true
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 46 : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 20 : i64
     = arith.constant -9 : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -47 : i64
     = arith.constant true
     = arith.constant 43 : i64
     = arith.constant -30 : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = arith.constant -5 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -45 : i64
     = arith.constant -33 : i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 11 : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -30 : i64
     = arith.constant -3 : i64
     = arith.constant -21 : i64
     = llvm.and ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -50 : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -26 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = arith.constant -43 : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -32 : i64
     = arith.constant -2 : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant 25 : i64
     = arith.constant true
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sgt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 42 : i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -50 : i64
     = arith.constant 49 : i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -3 : i64
     = arith.constant -26 : i64
     = llvm.and ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant 34 : i64
     = arith.constant -5 : i64
     = arith.constant 0 : i64
     = llvm.select , ,  : i1, i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 33 : i64
     = arith.constant -3 : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant -3 : i64
     = arith.constant 25 : i64
     = llvm.select , ,  : i1, i64
     = llvm.lshr ,  : i64
     = llvm.lshr ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = arith.constant 42 : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -15 : i64
     = arith.constant 5 : i64
     = arith.constant -37 : i64
     = arith.constant 16 : i64
     = llvm.xor ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.srem ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 2 : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -31 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant false
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant 41 : i64
     = arith.constant -18 : i64
     = arith.constant -38 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "sge" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 18 : i64
     = arith.constant -21 : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -35 : i64
     = llvm.udiv ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -26 : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i1) -> i1 {
     = arith.constant 27 : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "sle" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 12 : i64
     = arith.constant -43 : i64
     = arith.constant 49 : i64
     = arith.constant 37 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.urem ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = arith.constant -32 : i64
     = arith.constant -45 : i64
     = arith.constant 37 : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -40 : i64
     = llvm.sext  : i1 to i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -22 : i64
     = arith.constant false
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 46 : i64
     = arith.constant 3 : i64
     = llvm.xor ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -46 : i64
     = arith.constant -40 : i64
     = arith.constant -11 : i64
     = arith.constant -32 : i64
     = llvm.srem ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -5 : i64
     = arith.constant -18 : i64
     = arith.constant -11 : i64
     = arith.constant 6 : i64
     = llvm.urem ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = llvm.icmp "slt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 40 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -27 : i64
     = arith.constant 38 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.urem ,  : i64
     = llvm.icmp "ne" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant -9 : i64
     = arith.constant 46 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.or ,  : i64
     = llvm.urem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 17 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = arith.constant -38 : i64
     = arith.constant -7 : i64
     = llvm.udiv ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ule" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i1 {
     = arith.constant 27 : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 45 : i64
     = arith.constant -17 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -33 : i64
     = llvm.srem ,  : i64
     = llvm.or ,  : i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant 18 : i64
     = arith.constant 34 : i64
     = arith.constant -8 : i64
     = arith.constant 6 : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.ashr ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i1 {
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ult" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -9 : i64
     = arith.constant false
     = llvm.sext  : i1 to i64
     = llvm.icmp "uge" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant -16 : i64
     = llvm.icmp "ne" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = llvm.icmp "ugt" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i1 {
     = arith.constant -47 : i64
     = arith.constant 11 : i64
     = arith.constant -12 : i64
     = llvm.udiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "uge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = llvm.zext  : i1 to i64
     = llvm.select , ,  : i1, i64
     = llvm.xor ,  : i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1) -> i1 {
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i1, : i64) -> i64 {
     = llvm.zext  : i1 to i64
     = llvm.icmp "ne" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.lshr ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant false
     = arith.constant -18 : i64
     = arith.constant 9 : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main() -> i64 {
     = arith.constant -36 : i64
     = arith.constant -24 : i64
     = arith.constant -12 : i64
     = arith.constant 9 : i64
     = llvm.srem ,  : i64
     = llvm.ashr ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.sdiv ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant -36 : i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "sgt" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.and ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i64 {
     = llvm.srem ,  : i64
     = llvm.urem ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant 35 : i64
     = arith.constant 13 : i64
     = arith.constant false
     = arith.constant 19 : i64
     = llvm.sdiv ,  : i64
     = llvm.or ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 26 : i64
     = llvm.lshr ,  : i64
     = llvm.urem ,  : i64
     = llvm.or ,  : i64
     = llvm.ashr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 37 : i64
     = arith.constant -33 : i64
     = llvm.ashr ,  : i64
     = llvm.udiv ,  : i64
     = llvm.icmp "eq" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = llvm.sdiv ,  : i64
     = llvm.and ,  : i64
     = llvm.and ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -12 : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.urem ,  : i64
     = llvm.icmp "slt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant -28 : i64
     = llvm.trunc  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.urem ,  : i64
     = llvm.lshr ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 16 : i64
     = llvm.xor ,  : i64
     = llvm.sdiv ,  : i64
     = llvm.udiv ,  : i64
     = llvm.or ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i1, : i64) -> i64 {
     = arith.constant 19 : i64
     = llvm.icmp "uge" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.select , ,  : i1, i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i1 {
     = arith.constant 44 : i64
     = arith.constant -34 : i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
     = llvm.srem ,  : i64
     = llvm.icmp "eq" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = arith.constant 3 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i64 {
     = llvm.ashr ,  : i64
     = llvm.ashr ,  : i64
     = llvm.icmp "sle" ,  : i64
     = llvm.trunc  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i1 {
     = arith.constant -35 : i64
     = llvm.xor ,  : i64
     = llvm.icmp "ule" ,  : i64
     = llvm.sext  : i1 to i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = llvm.udiv ,  : i64
     = llvm.icmp "sge" ,  : i64
     = llvm.select , ,  : i1, i64
     = llvm.icmp "sge" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64) -> i64 {
     = llvm.lshr ,  : i64
     = llvm.or ,  : i64
     = llvm.icmp "ugt" ,  : i64
     = llvm.zext  : i1 to i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64) -> i64 {
     = arith.constant 27 : i64
     = arith.constant -45 : i64
     = llvm.icmp "ult" ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.srem ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i1) -> i1 {
     = llvm.xor ,  : i64
     = llvm.zext  : i1 to i64
     = llvm.ashr ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i64, : i64, : i64) -> i1 {
     = arith.constant -19 : i64
     = llvm.icmp "slt" ,  : i64
     = llvm.trunc  : i1 to i64
     = llvm.sdiv ,  : i64
     = llvm.icmp "ugt" ,  : i64
    return  : i1
  }
}
// -----
module {
  func.func @main(: i1, : i64, : i64) -> i64 {
     = arith.constant -46 : i64
     = arith.constant 40 : i64
     = llvm.select , ,  : i1, i64
     = llvm.udiv ,  : i64
     = llvm.xor ,  : i64
     = llvm.xor ,  : i64
    return  : i64
  }
}
// -----
