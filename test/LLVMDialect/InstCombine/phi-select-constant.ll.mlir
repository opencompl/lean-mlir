module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global extern_weak @A() {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global extern_weak @B() {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @foo(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.addressof @A : !llvm.ptr
    %2 = llvm.mlir.addressof @B : !llvm.ptr
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.br ^bb2(%5 : i1)
  ^bb2(%6: i1):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.select %6, %3, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @vec1(%arg0: i1) -> vector<4xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<[true, true, false, false]> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %6 = llvm.mlir.constant(dense<[124, 125, 126, 127]> : vector<4xi64>) : vector<4xi64>
    llvm.cond_br %arg0, ^bb2(%1 : vector<4xi1>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3 : vector<4xi1>)
  ^bb2(%7: vector<4xi1>):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.select %7, %5, %6 : vector<4xi1>, vector<4xi64>
    llvm.return %8 : vector<4xi64>
  }
  llvm.func @vec2(%arg0: i1) -> vector<4xi64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<[true, false, true, false]> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %6 = llvm.mlir.constant(dense<[124, 125, 126, 127]> : vector<4xi64>) : vector<4xi64>
    llvm.cond_br %arg0, ^bb2(%1 : vector<4xi1>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3 : vector<4xi1>)
  ^bb2(%7: vector<4xi1>):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.select %7, %5, %6 : vector<4xi1>, vector<4xi64>
    llvm.return %8 : vector<4xi64>
  }
  llvm.func @vec3(%arg0: i1, %arg1: i1, %arg2: vector<2xi1>, %arg3: vector<2xi8>, %arg4: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<[false, true]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    llvm.cond_br %arg0, ^bb1, ^bb3(%2 : vector<2xi1>)
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3(%3 : vector<2xi1>)
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%arg2 : vector<2xi1>)
  ^bb3(%4: vector<2xi1>):  // 3 preds: ^bb0, ^bb1, ^bb2
    %5 = llvm.select %4, %arg3, %arg4 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @PR48369(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.br ^bb1(%1 : i1)
  ^bb1(%4: i1):  // pred: ^bb0
    %5 = llvm.select %4, %2, %0 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @sink_to_unreachable_crash(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.select %arg0, %0, %1 : i1, i16
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb1
  }
  llvm.func @phi_trans(%arg0: i1, %arg1: i1, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg2, %1  : i32
    %4 = llvm.shl %arg2, %1  : i32
    llvm.br ^bb3(%2, %3, %4 : i1, i32, i32)
  ^bb2:  // pred: ^bb0
    %5 = llvm.mul %arg2, %0  : i32
    %6 = llvm.lshr %arg2, %1  : i32
    llvm.br ^bb3(%arg1, %5, %6 : i1, i32, i32)
  ^bb3(%7: i1, %8: i32, %9: i32):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.select %7, %8, %9 : i1, i32
    llvm.return %10 : i32
  }
}
