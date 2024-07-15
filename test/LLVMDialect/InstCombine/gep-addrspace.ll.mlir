module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal @array(dense<0.000000e+00> : tensor<256xf32>) {addr_space = 3 : i32, alignment = 4 : i64, dso_local} : !llvm.array<256 x f32>
  llvm.mlir.global internal @scalar(0.000000e+00 : f32) {addr_space = 3 : i32, alignment = 4 : i64, dso_local} : f32
  llvm.func @func(%arg0: !llvm.ptr<1> {llvm.nocapture}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"myStruct", (f32, array<3 x f32>, array<4 x f32>, i32)>
    %6 = llvm.getelementptr inbounds %5[%0, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<3 x f32>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %8 = llvm.fsub %7, %3  : f32
    llvm.return
  }
  llvm.func @keep_necessary_addrspacecast(%arg0: i64, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : tensor<256xf32>) : !llvm.array<256 x f32>
    %2 = llvm.mlir.addressof @array : !llvm.ptr<3>
    %3 = llvm.addrspacecast %2 : !llvm.ptr<3> to !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.addressof @scalar : !llvm.ptr<3>
    %6 = llvm.addrspacecast %5 : !llvm.ptr<3> to !llvm.ptr
    %7 = llvm.getelementptr %3[%4, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<256 x f32>
    %8 = llvm.getelementptr %6[%4, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x f32>
    llvm.store %7, %arg1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %8, %arg2 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @escape_alloca(!llvm.ptr)
  llvm.func @inbounds_after_addrspacecast() -> !llvm.struct<(i8, i8)> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<(i8, i8)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(i8, i8)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<(i8, i8)> 
    %7 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr
    llvm.call @escape_alloca(%7) : (!llvm.ptr) -> ()
    %8 = llvm.addrspacecast %7 : !llvm.ptr to !llvm.ptr<11>
    %9 = llvm.getelementptr %8[%1, %2] : (!llvm.ptr<11>, i64, i64) -> !llvm.ptr<11>, !llvm.array<2 x i8>
    %10 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr<11> -> i8
    %11 = llvm.insertvalue %10, %6[1] : !llvm.struct<(i8, i8)> 
    llvm.return %11 : !llvm.struct<(i8, i8)>
  }
  llvm.func spir_funccc @my_extern_func() -> vector<16xi32>
  llvm.func @bitcast_after_gep(%arg0: !llvm.ptr) {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.call spir_funccc @my_extern_func() : () -> vector<16xi32>
    llvm.store %1, %0 {alignment = 64 : i64} : vector<16xi32>, !llvm.ptr<3>
    llvm.return
  }
}
