module  {
  llvm.func @use(i8)
  llvm.func @use16(i16)
  llvm.func @testi16i8(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi16i8_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %3, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi16i8_ne(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "ne" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi16i8_ne_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "ne" %3, %5 : i8
    llvm.return %6 : i1
  }
  llvm.func @testi64i32(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.lshr %arg0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %0  : i32
    %6 = llvm.icmp "eq" %5, %3 : i32
    llvm.return %6 : i1
  }
  llvm.func @testi64i32_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.lshr %arg0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %0  : i32
    %6 = llvm.icmp "ne" %5, %3 : i32
    llvm.return %6 : i1
  }
  llvm.func @testi32i8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @wrongimm1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(7 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @wrongimm2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }
  llvm.func @slt(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.lshr %arg0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %0  : i32
    %6 = llvm.icmp "slt" %5, %3 : i32
    llvm.return %6 : i1
  }
  llvm.func @extrause_a(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.return %6 : i1
  }
  llvm.func @extrause_l(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%3) : (i8) -> ()
    llvm.return %6 : i1
  }
  llvm.func @extrause_la(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.lshr %arg0, %1  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %0  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.return %6 : i1
  }
}
