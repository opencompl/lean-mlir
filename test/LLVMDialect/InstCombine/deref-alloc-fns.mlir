module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("hello\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @malloc(i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = [["allockind", "9"], ["allocsize", "4294967295"], ["alloc-family", "malloc"]]}
  llvm.func @calloc(i64, i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = [["allockind", "17"], ["allocsize", "1"], ["alloc-family", "malloc"]]}
  llvm.func @realloc(!llvm.ptr {llvm.nocapture}, i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = [["allockind", "2"], ["allocsize", "8589934591"], ["alloc-family", "malloc"]]}
  llvm.func @_Znam(i64) -> (!llvm.ptr {llvm.noalias, llvm.nonnull})
  llvm.func @_Znwm(i64) -> (!llvm.ptr {llvm.noalias, llvm.nonnull})
  llvm.func @strdup(!llvm.ptr) -> (!llvm.ptr {llvm.noalias})
  llvm.func @aligned_alloc(i64 {llvm.allocalign}, i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = [["allockind", "41"], ["allocsize", "8589934591"], ["alloc-family", "malloc"]]}
  llvm.func @memalign(i64 {llvm.allocalign}, i64) -> (!llvm.ptr {llvm.align = 16 : i64, llvm.noalias}) attributes {passthrough = [["allocsize", "8589934591"]]}
  llvm.func @_ZnamSt11align_val_t(i64, i64) -> (!llvm.ptr {llvm.noalias})
  llvm.func @my_malloc(i64) -> !llvm.ptr attributes {passthrough = [["allocsize", "4294967295"]]}
  llvm.func @my_calloc(i64, i64) -> !llvm.ptr attributes {passthrough = [["allocsize", "1"]]}
  llvm.func @malloc_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @malloc(%arg0) : (i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @malloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @aligned_alloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(512 : i64) : i64
    %2 = llvm.call @aligned_alloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @aligned_alloc_unknown_size_nonzero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(128 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @aligned_alloc(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @aligned_alloc(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @aligned_alloc_unknown_align(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.call @aligned_alloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @foo(!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (!llvm.ptr {llvm.noalias})
  llvm.func @aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.call @aligned_alloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    %4 = llvm.call @aligned_alloc(%1, %0) : (i64, i64) -> !llvm.ptr
    %5 = llvm.call @aligned_alloc(%2, %arg1) : (i64, i64) -> !llvm.ptr
    %6 = llvm.call @foo(%3, %4, %5) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @memalign_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(512 : i64) : i64
    %2 = llvm.call @memalign(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @memalign_unknown_size_nonzero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(128 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @memalign(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memalign_unknown_size_possibly_zero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @memalign(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memalign_unknown_align(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.call @memalign(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @malloc_constant_size2() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @malloc_constant_size3() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @malloc_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @realloc(%arg0, %arg1) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @realloc_constant_zero_size(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @realloc_constant_size(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @calloc_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @calloc(%0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @calloc_nonconstant_size2(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @calloc_nonconstant_size3(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @calloc(%arg0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @calloc_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @calloc_constant_zero_size2(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @calloc_constant_zero_size3(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @calloc_constant_zero_size4(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @calloc_constant_zero_size5(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @calloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @calloc_constant_size_overflow() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(2000000000000 : i64) : i64
    %1 = llvm.mlir.constant(80000000000 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @op_new_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @_Znam(%arg0) : (i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @op_new_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @op_new_constant_size2() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @op_new_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @strdup_constant_str() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @strdup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @strdup_notconstant_str(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @strdup(%arg0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @ossfuzz_23214() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %2 = llvm.mlir.constant(512 : i64) : i64
    %3 = llvm.and %0, %1  : i64
    %4 = llvm.call @aligned_alloc(%3, %2) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @op_new_align() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @_ZnamSt11align_val_t(%0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @my_malloc_constant_size() -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @my_malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @my_calloc_constant_size() -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.call @my_calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
}
