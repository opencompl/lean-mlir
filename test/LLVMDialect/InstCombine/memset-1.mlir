module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @memset(!llvm.ptr, i32, i32) -> !llvm.ptr
  llvm.func @malloc(i32) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]}
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_simplify1_tail(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_simplify1_musttail(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @pr25892_lite(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    %2 = llvm.call @memset(%1, %0, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @malloc_and_memset_intrinsic(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    "llvm.intr.memset"(%1, %0, %arg0) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @notmalloc_memset(%arg0: i32, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call %arg1(%arg0) : !llvm.ptr, (i32) -> !llvm.ptr
    %2 = llvm.call @memset(%1, %0, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @pr25892(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %0 : !llvm.ptr
    llvm.cond_br %3, ^bb2(%0 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.call @memset(%2, %1, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.br ^bb2(%2 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @buffer_is_modified_then_memset(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    llvm.store %0, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    %3 = llvm.call @memset(%2, %1, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @memset_size_select(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memset_size_select2(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memset_size_select3(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memset_size_select4(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @memset_size_ashr(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %0, %arg2  : i32
    %3 = llvm.call @memset(%arg1, %1, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @memset_attrs1(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memset_attrs2(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memset_attrs3(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @memset_attrs4(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
}
