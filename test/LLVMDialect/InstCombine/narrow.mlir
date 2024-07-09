module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.zext %0 : i1 to i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.trunc %4 : i32 to i1
    llvm.return %5 : i1
  }
  llvm.func @shrink_xor(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @shrink_xor_vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.xor %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @shrink_or(%arg0: i6) -> i3 {
    %0 = llvm.mlir.constant(-31 : i6) : i6
    %1 = llvm.or %arg0, %0  : i6
    %2 = llvm.trunc %1 : i6 to i3
    llvm.return %2 : i3
  }
  llvm.func @shrink_or_vec(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-1, 256]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.or %arg0, %0  : vector<2xi16>
    %2 = llvm.trunc %1 : vector<2xi16> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @shrink_and(%arg0: i64) -> i31 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i31
    llvm.return %2 : i31
  }
  llvm.func @shrink_and_vec(%arg0: vector<2xi33>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(6 : i33) : i33
    %1 = llvm.mlir.constant(-4294967296 : i33) : i33
    %2 = llvm.mlir.constant(dense<[-4294967296, 6]> : vector<2xi33>) : vector<2xi33>
    %3 = llvm.and %arg0, %2  : vector<2xi33>
    %4 = llvm.trunc %3 : vector<2xi33> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @searchArray1(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1000 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i8)
  ^bb1(%4: i32, %5: i8):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr %arg1[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.icmp "eq" %7, %arg0 : i32
    %9 = llvm.zext %8 : i1 to i8
    %10 = llvm.or %5, %9  : i8
    %11 = llvm.add %4, %2  : i32
    %12 = llvm.icmp "eq" %11, %3 : i32
    llvm.cond_br %12, ^bb2, ^bb1(%11, %10 : i32, i8)
  ^bb2:  // pred: ^bb1
    %13 = llvm.icmp "ne" %10, %1 : i8
    llvm.return %13 : i1
  }
  llvm.func @searchArray2(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    %4 = llvm.mlir.constant(0 : i8) : i8
    llvm.br ^bb1(%0, %1 : i64, i8)
  ^bb1(%5: i64, %6: i8):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.getelementptr %arg1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.icmp "eq" %8, %arg0 : i32
    %10 = llvm.zext %9 : i1 to i8
    %11 = llvm.and %6, %10  : i8
    %12 = llvm.add %5, %2  : i64
    %13 = llvm.icmp "eq" %12, %3 : i64
    llvm.cond_br %13, ^bb2, ^bb1(%12, %11 : i64, i8)
  ^bb2:  // pred: ^bb1
    %14 = llvm.icmp "ne" %11, %4 : i8
    llvm.return %14 : i1
  }
  llvm.func @shrinkLogicAndPhi1(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @shrinkLogicAndPhi2(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
}
