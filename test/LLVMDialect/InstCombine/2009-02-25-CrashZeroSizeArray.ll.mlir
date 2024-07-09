module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @_ada_c32001b(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(0 : i8) : i8
    %7 = llvm.select %0, %arg0, %1 : i1, i32
    %8 = llvm.mul %7, %2  : i32
    %9 = llvm.alloca %1 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %10 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i32
    %11 = llvm.icmp "eq" %10, %3 : i32
    %12 = llvm.zext %11 : i1 to i8
    %13 = llvm.ashr %8, %4  : i32
    %14 = llvm.mul %13, %2  : i32
    %15 = llvm.mul %5, %14  : i32
    %16 = llvm.getelementptr %9[%15] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %17 = llvm.getelementptr %16[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %18 = llvm.load %17 {alignment = 1 : i64} : !llvm.ptr -> i32
    %19 = llvm.icmp "eq" %18, %2 : i32
    %20 = llvm.zext %19 : i1 to i8
    %21 = llvm.icmp "ne" %12, %6 : i8
    %22 = llvm.icmp "ne" %20, %6 : i8
    %23 = llvm.and %21, %22  : i1
    %24 = llvm.zext %23 : i1 to i8
    %25 = llvm.icmp "ne" %24, %6 : i8
    llvm.cond_br %25, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}
