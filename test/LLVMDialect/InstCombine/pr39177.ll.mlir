module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @stderr() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr
  llvm.mlir.global private constant @".str"("crash!\0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @__fwrite_alias(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %3 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.store %arg2, %4 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.store %arg3, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %1 : i64
  }
  llvm.func @foo() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("crash!\0A\00") : !llvm.array<8 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.call @fprintf(%6, %4) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
}
