module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @julia_2xdouble(%arg0: !llvm.ptr {llvm.sret = !llvm.array<2 x f64>}, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.array<2 x f64>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<2xf64>
    %4 = llvm.extractelement %3[%0 : i32] : vector<2xf64>
    %5 = llvm.insertvalue %4, %1[0] : !llvm.array<2 x f64> 
    %6 = llvm.extractelement %3[%2 : i32] : vector<2xf64>
    %7 = llvm.insertvalue %6, %5[1] : !llvm.array<2 x f64> 
    llvm.store %7, %arg0 {alignment = 4 : i64} : !llvm.array<2 x f64>, !llvm.ptr
    llvm.return
  }
  llvm.func @julia_2xi64(%arg0: !llvm.ptr {llvm.sret = !llvm.array<2 x i64>}, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.array<2 x i64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<2xi64>
    %4 = llvm.extractelement %3[%0 : i32] : vector<2xi64>
    %5 = llvm.insertvalue %4, %1[0] : !llvm.array<2 x i64> 
    %6 = llvm.extractelement %3[%0 : i32] : vector<2xi64>
    %7 = llvm.insertvalue %6, %5[1] : !llvm.array<2 x i64> 
    %8 = llvm.extractelement %3[%2 : i32] : vector<2xi64>
    %9 = llvm.insertvalue %8, %7[0] : !llvm.array<2 x i64> 
    llvm.store %9, %arg0 {alignment = 4 : i64} : !llvm.array<2 x i64>, !llvm.ptr
    llvm.return
  }
  llvm.func @julia_4xfloat(%arg0: !llvm.ptr {llvm.sret = !llvm.array<4 x f32>}, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.array<4 x f32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>
    %6 = llvm.extractelement %5[%0 : i32] : vector<4xf32>
    %7 = llvm.insertvalue %6, %1[0] : !llvm.array<4 x f32> 
    %8 = llvm.extractelement %5[%2 : i32] : vector<4xf32>
    %9 = llvm.insertvalue %8, %7[1] : !llvm.array<4 x f32> 
    %10 = llvm.extractelement %5[%3 : i32] : vector<4xf32>
    %11 = llvm.insertvalue %10, %9[2] : !llvm.array<4 x f32> 
    %12 = llvm.extractelement %5[%4 : i32] : vector<4xf32>
    %13 = llvm.insertvalue %12, %11[3] : !llvm.array<4 x f32> 
    llvm.store %13, %arg0 {alignment = 4 : i64} : !llvm.array<4 x f32>, !llvm.ptr
    llvm.return
  }
  llvm.func @julia_pseudovec(%arg0: !llvm.ptr {llvm.sret = !llvm.struct<"pseudovec", (f32, f32, f32, f32)>}, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"pseudovec", (f32, f32, f32, f32)>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>
    %6 = llvm.extractelement %5[%0 : i32] : vector<4xf32>
    %7 = llvm.insertvalue %6, %1[0] : !llvm.struct<"pseudovec", (f32, f32, f32, f32)> 
    %8 = llvm.extractelement %5[%2 : i32] : vector<4xf32>
    %9 = llvm.insertvalue %8, %7[1] : !llvm.struct<"pseudovec", (f32, f32, f32, f32)> 
    %10 = llvm.extractelement %5[%3 : i32] : vector<4xf32>
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<"pseudovec", (f32, f32, f32, f32)> 
    %12 = llvm.extractelement %5[%4 : i32] : vector<4xf32>
    %13 = llvm.insertvalue %12, %11[3] : !llvm.struct<"pseudovec", (f32, f32, f32, f32)> 
    llvm.store %13, %arg0 {alignment = 4 : i64} : !llvm.struct<"pseudovec", (f32, f32, f32, f32)>, !llvm.ptr
    llvm.return
  }
}
