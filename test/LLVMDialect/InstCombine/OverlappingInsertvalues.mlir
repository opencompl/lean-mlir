module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo_simple(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.struct<(ptr, i64, i32)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i32)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, i64, i32)> 
    %2 = llvm.insertvalue %arg1, %1[0] : !llvm.struct<(ptr, i64, i32)> 
    llvm.return %2 : !llvm.struct<(ptr, i64, i32)>
  }
  llvm.func @foo_ovwrt_chain(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<(ptr, i64, i32)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, i64, i32)>
    %1 = llvm.mlir.constant(555 : i32) : i32
    %2 = llvm.mlir.constant(777 : i32) : i32
    %3 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, i64, i32)> 
    %4 = llvm.insertvalue %arg1, %3[1] : !llvm.struct<(ptr, i64, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<(ptr, i64, i32)> 
    %6 = llvm.insertvalue %arg2, %5[1] : !llvm.struct<(ptr, i64, i32)> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.struct<(ptr, i64, i32)> 
    llvm.return %7 : !llvm.struct<(ptr, i64, i32)>
  }
  llvm.func @foo_use_as_second_operand(%arg0: i16) -> !llvm.struct<(i8, struct<(i16, i32)>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : !llvm.struct<(i16, i32)>
    %1 = llvm.mlir.undef : !llvm.struct<(i8, struct<(i16, i32)>)>
    %2 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i16, i32)> 
    %3 = llvm.insertvalue %2, %1[1] : !llvm.struct<(i8, struct<(i16, i32)>)> 
    llvm.return %3 : !llvm.struct<(i8, struct<(i16, i32)>)>
  }
}
