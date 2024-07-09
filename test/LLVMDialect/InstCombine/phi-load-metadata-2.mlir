module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bar()
  llvm.func @baz()
  llvm.func @test_phi_combine_load_metadata(%arg0: i1, %arg1: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg2: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> !llvm.ptr {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    %0 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb3(%0 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @baz() : () -> ()
    %1 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb3(%2: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.ptr
  }
}
