module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %2, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %3, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %2, %1) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %2, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    "llvm.intr.memcpy"(%arg0, %3, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i16
    llvm.store %1, %4 {alignment = 2 : i64} : i16, !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %4, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
}
