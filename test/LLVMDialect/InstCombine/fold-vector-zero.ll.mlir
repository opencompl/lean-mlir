module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-2222 : i64) : i64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %4 = llvm.mlir.undef : vector<2xi64>
    %5 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.constant(16 : i64) : i64
    %10 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i64)
  ^bb1(%11: i64, %12: i64):  // 2 preds: ^bb0, ^bb1
    %13 = llvm.add %11, %arg1  : i64
    %14 = llvm.inttoptr %13 : i64 to !llvm.ptr
    %15 = llvm.load %14 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf64>
    %16 = llvm.bitcast %15 : vector<2xf64> to vector<2xi64>
    %17 = llvm.bitcast %3 : vector<2xf64> to vector<2xi64>
    %18 = llvm.insertelement %5, %4[%6 : i32] : vector<2xi64>
    %19 = llvm.insertelement %7, %4[%6 : i32] : vector<2xi64>
    %20 = llvm.insertelement %5, %18[%8 : i32] : vector<2xi64>
    %21 = llvm.insertelement %7, %19[%8 : i32] : vector<2xi64>
    %22 = llvm.and %16, %20  : vector<2xi64>
    %23 = llvm.and %17, %21  : vector<2xi64>
    %24 = llvm.or %22, %23  : vector<2xi64>
    %25 = llvm.bitcast %24 : vector<2xi64> to vector<2xf64>
    %26 = llvm.add %11, %arg0  : i64
    %27 = llvm.inttoptr %26 : i64 to !llvm.ptr
    llvm.store %25, %27 {alignment = 8 : i64} : vector<2xf64>, !llvm.ptr
    %28 = llvm.add %9, %11  : i64
    %29 = llvm.add %10, %12  : i64
    %30 = llvm.icmp "slt" %29, %0 : i64
    %31 = llvm.zext %30 : i1 to i64
    %32 = llvm.icmp "ne" %31, %0 : i64
    llvm.cond_br %32, ^bb1(%28, %29 : i64, i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
}
