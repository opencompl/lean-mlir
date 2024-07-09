module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo1(%arg0: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.mul %5, %1  : i32
    llvm.store %6, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.trunc %7 : i32 to i16
    llvm.return %8 : i16
  }
  llvm.func @foo2(%arg0: i32, %arg1: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %arg1, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.sub %5, %6  : i32
    %8 = llvm.mul %7, %1  : i32
    llvm.store %8, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.trunc %9 : i32 to i16
    llvm.return %10 : i16
  }
  llvm.func @foo3(%arg0: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.mul %6, %2  : i32
    llvm.store %7, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }
}
