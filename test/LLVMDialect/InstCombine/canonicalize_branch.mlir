module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @eq(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([0, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @ne(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([1, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([2, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @uge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([3, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @ult(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([4, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @ule(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([5, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @sgt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([6, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @sge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([7, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @slt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([8, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @sle(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([9, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_false(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([10, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_oeq(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([11, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_ogt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([12, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_oge(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([13, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_olt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([14, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_ole(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([15, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_one(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "one" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([16, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_ord(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([17, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_uno(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([18, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_ueq(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([19, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_ugt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([20, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_uge(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([21, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_ult(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([22, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_ule(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([23, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_une(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "une" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([24, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @f_true(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "_true" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([25, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
}
