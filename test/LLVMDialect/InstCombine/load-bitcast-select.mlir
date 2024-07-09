module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @a(dense<0.000000e+00> : tensor<1000xf32>) {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.array<1000 x f32>
  llvm.mlir.global external @b(dense<0.000000e+00> : tensor<1000xf32>) {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.array<1000 x f32>
  llvm.func @_Z3foov() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1000 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : tensor<1000xf32>) : !llvm.array<1000 x f32>
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%8: i32):  // 2 preds: ^bb0, ^bb3
    %9 = llvm.icmp "ult" %8, %1 : i32
    llvm.cond_br %9, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    %10 = llvm.zext %8 : i32 to i64
    %11 = llvm.getelementptr inbounds %4[%5, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f32>
    %12 = llvm.getelementptr inbounds %6[%5, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f32>
    %13 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> f32
    %14 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32
    %15 = llvm.fcmp "olt" %13, %14 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %16 = llvm.select %15, %12, %11 : i1, !llvm.ptr
    %17 = llvm.load %16 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %17, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %18 = llvm.add %8, %7 overflow<nsw, nuw>  : i32
    llvm.br ^bb1(%18 : i32)
  }
  llvm.func @store_bitcasted_load(%arg0: i1, %arg1: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg2: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @bitcasted_store(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %1, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcasted_minmax_with_select_of_pointers(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32
    %1 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> f32
    %2 = llvm.fcmp "ogt" %0, %1 : f32
    %3 = llvm.select %2, %arg0, %arg1 : i1, !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
