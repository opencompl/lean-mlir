module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @widen_align_from_allocalign_callsite() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.call @my_aligned_alloc_2(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @widen_align_from_allocalign() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.call @my_aligned_alloc(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @dont_narrow_align_from_allocalign() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.call @my_aligned_alloc(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @my_aligned_alloc_3(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.allocalign}) -> !llvm.ptr {
    %0 = llvm.call @my_aligned_alloc_2(%arg0, %arg1) : (i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @allocalign_disappears() -> !llvm.ptr {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.call @my_aligned_alloc_3(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @my_aligned_alloc(i32 {llvm.noundef}, i32 {llvm.allocalign, llvm.noundef}) -> !llvm.ptr
  llvm.func @my_aligned_alloc_2(i32 {llvm.noundef}, i32 {llvm.noundef}) -> !llvm.ptr
}
