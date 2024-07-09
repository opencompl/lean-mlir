module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @glb(0 : i8) {addr_space = 0 : i32} : i8
  llvm.func @const(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.freeze %2 : i32
    llvm.return %3 : i32
  }
  llvm.func @vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xi32>)
  ^bb3(%2: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.freeze %2 : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @vec_undef(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%7 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%6 : vector<2xi32>)
  ^bb3(%8: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.freeze %8 : vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }
  llvm.func @one(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb3(%1: i32):  // 2 preds: ^bb1, ^bb2
    %2 = llvm.freeze %1 : i32
    llvm.return %2 : i32
  }
  llvm.func @two(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.freeze %0 : i32
    llvm.return %1 : i32
  }
  llvm.func @two_undef(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%arg1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %3 = llvm.freeze %2 : i32
    llvm.return %3 : i32
  }
  llvm.func @one_undef(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.undef : i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%3: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.freeze %3 : i32
    llvm.return %4 : i32
  }
  llvm.func @one_constexpr(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.addressof @glb : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i32
    llvm.switch %arg0 : i8, ^bb1 [
      0: ^bb2,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%6 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb4(%7: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %8 = llvm.freeze %7 : i32
    llvm.return %8 : i32
  }
}
