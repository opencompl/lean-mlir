module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr, %arg5: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.mlir.constant(true) : i1
    %7 = llvm.and %arg2, %0  : i32
    %8 = llvm.shl %7, %1  : i32
    %9 = llvm.ashr %arg2, %0  : i32
    %10 = llvm.shl %9, %1  : i32
    %11 = llvm.ashr %8, %2  : i32
    llvm.store %11, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.ashr %10, %2  : i32
    llvm.store %12, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.icmp "eq" %arg3, %3 : i32
    %14 = llvm.zext %13 : i1 to i8
    %15 = llvm.icmp "ne" %14, %4 : i8
    llvm.cond_br %15, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %8, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %10, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.store %8, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %10, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %5 : i1
  }
}
