module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mul_full_64(%arg0: i64, %arg1: i64) -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %arg1, %0  : i64
    %6 = llvm.lshr %arg1, %1  : i64
    %7 = llvm.mul %5, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %4 overflow<nuw>  : i64
    %9 = llvm.mul %6, %3 overflow<nuw>  : i64
    %10 = llvm.mul %6, %4 overflow<nuw>  : i64
    %11 = llvm.and %7, %0  : i64
    %12 = llvm.lshr %7, %1  : i64
    %13 = llvm.add %12, %8  : i64
    %14 = llvm.and %13, %0  : i64
    %15 = llvm.lshr %13, %1  : i64
    %16 = llvm.add %14, %9  : i64
    %17 = llvm.shl %16, %1  : i64
    %18 = llvm.lshr %16, %1  : i64
    %19 = llvm.add %15, %10  : i64
    %20 = llvm.or %17, %11  : i64
    %21 = llvm.add %19, %18  : i64
    %22 = llvm.insertvalue %20, %2[0] : !llvm.struct<(i64, i64)> 
    %23 = llvm.insertvalue %21, %22[1] : !llvm.struct<(i64, i64)> 
    llvm.return %23 : !llvm.struct<(i64, i64)>
  }
  llvm.func @mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.lshr %arg1, %1  : i32
    %7 = llvm.mul %5, %3 overflow<nuw>  : i32
    %8 = llvm.mul %5, %4 overflow<nuw>  : i32
    %9 = llvm.mul %6, %3 overflow<nuw>  : i32
    %10 = llvm.mul %6, %4 overflow<nuw>  : i32
    %11 = llvm.and %7, %0  : i32
    %12 = llvm.lshr %7, %1  : i32
    %13 = llvm.add %12, %8  : i32
    %14 = llvm.and %13, %0  : i32
    %15 = llvm.lshr %13, %1  : i32
    %16 = llvm.add %14, %9  : i32
    %17 = llvm.shl %16, %1  : i32
    %18 = llvm.lshr %16, %1  : i32
    %19 = llvm.add %15, %10  : i32
    %20 = llvm.or %17, %11  : i32
    %21 = llvm.add %19, %18  : i32
    %22 = llvm.insertvalue %20, %2[0] : !llvm.struct<(i32, i32)> 
    %23 = llvm.insertvalue %21, %22[1] : !llvm.struct<(i32, i32)> 
    llvm.return %23 : !llvm.struct<(i32, i32)>
  }
}
