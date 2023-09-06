module  {
  llvm.func @and_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @xor_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @xor_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_signbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_nosignbit_shl(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @xor_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @xor_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_signbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_nosignbit_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @xor_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @xor_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_signbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_nosignbit_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(2147418112 : i32) : i32
    %2 = llvm.add %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
}
