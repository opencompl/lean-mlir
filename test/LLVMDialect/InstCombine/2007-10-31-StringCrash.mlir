module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @__darwin_gcc3_preregister_frame_info()
  llvm.func @_start(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.addressof @__darwin_gcc3_preregister_frame_info : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}
