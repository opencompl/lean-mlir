module  {
  llvm.mlir.global external @b() : !llvm.array<1 x i16>
  llvm.func @test1(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.udiv %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }
  llvm.func @test2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.udiv %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }
  llvm.func @test1_PR2274(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.udiv %1, %arg1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test2_PR2274(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.udiv %1, %arg1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @PR30366(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @b : !llvm.ptr<array<1 x i16>>
    %1 = llvm.ptrtoint %0 : !llvm.ptr<array<1 x i16>> to i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.shl %2, %1  : i16
    %4 = llvm.zext %3 : i16 to i32
    %5 = llvm.zext %arg0 : i1 to i32
    %6 = llvm.udiv %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @ossfuzz_4857(%arg0: i177, %arg1: i177) -> i177 {
    %0 = llvm.mlir.undef : !llvm.ptr<i1>
    %1 = llvm.mlir.constant(-1 : i177) : i177
    %2 = llvm.udiv %arg1, %1  : i177
    %3 = llvm.add %2, %1  : i177
    %4 = llvm.add %3, %1  : i177
    %5 = llvm.mul %2, %4  : i177
    %6 = llvm.add %4, %4  : i177
    %7 = llvm.xor %3, %6  : i177
    %8 = llvm.ashr %arg1, %4  : i177
    %9 = llvm.add %7, %8  : i177
    %10 = llvm.udiv %2, %5  : i177
    %11 = llvm.icmp "ult" %arg1, %9 : i177
    llvm.store %11, %0 : !llvm.ptr<i1>
    llvm.return %10 : i177
  }
  llvm.func @udiv_demanded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.udiv %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @udiv_exact_demanded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.udiv %2, %0  : i32
    llvm.return %3 : i32
  }
}
