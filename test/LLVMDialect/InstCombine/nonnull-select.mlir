module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pr48975(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull, llvm.noundef}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull, llvm.noundef}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @nonnull_call(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @nonnull_call2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @nonnull_noundef_call(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @nonnull_noundef_call2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @f(!llvm.ptr)
}
