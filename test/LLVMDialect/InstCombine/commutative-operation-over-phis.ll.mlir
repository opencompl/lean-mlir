module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @dummy()
  llvm.func @fold_phi_mul(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_mul_three(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb3(%arg2, %arg3 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.cond_br %arg1, ^bb2, ^bb3(%arg3, %arg2 : i8, i8)
  ^bb2:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%arg2, %arg3 : i8, i8)
  ^bb3(%0: i8, %1: i8):  // 3 preds: ^bb0, ^bb1, ^bb2
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_mul_three_notopt(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb3(%arg2, %arg3 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.cond_br %arg1, ^bb2, ^bb3(%arg3, %arg2 : i8, i8)
  ^bb2:  // pred: ^bb1
    llvm.call @dummy() : () -> ()
    llvm.br ^bb3(%arg2, %arg2 : i8, i8)
  ^bb3(%0: i8, %1: i8):  // 3 preds: ^bb0, ^bb1, ^bb2
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_mul_nsw_nuw(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_mul_fix_vec(%arg0: i1, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xi8>, vector<2xi8>)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : vector<2xi8>, vector<2xi8>)
  ^bb2(%0: vector<2xi8>, %1: vector<2xi8>):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @fold_phi_mul_scale_vec(%arg0: i1, %arg1: !llvm.vec<? x 2 x  i8>, %arg2: !llvm.vec<? x 2 x  i8>) -> !llvm.vec<? x 2 x  i8> {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : !llvm.vec<? x 2 x  i8>, !llvm.vec<? x 2 x  i8>)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : !llvm.vec<? x 2 x  i8>, !llvm.vec<? x 2 x  i8>)
  ^bb2(%0: !llvm.vec<? x 2 x  i8>, %1: !llvm.vec<? x 2 x  i8>):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : !llvm.vec<? x 2 x  i8>
    llvm.return %2 : !llvm.vec<? x 2 x  i8>
  }
  llvm.func @fold_phi_mul_commute(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_mul_notopt(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg3 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.mul %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_sub(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_add(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.add %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_and(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.and %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_or(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_xor(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i8, i8)
  ^bb2(%0: i8, %1: i8):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.xor %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @fold_phi_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.fadd %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fold_phi_fadd_nnan(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fold_phi_fmul(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.fmul %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fold_phi_smax(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.smax(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fold_phi_smin(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.smin(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fold_phi_umax(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.umax(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fold_phi_umin(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.umin(%0, %1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @fold_phi_maxnum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.maxnum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fold_phi_pow(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fold_phi_minnum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.minnum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fold_phi_maximum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fold_phi_minimum(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.call @dummy() : () -> ()
    llvm.br ^bb2(%arg2, %arg1 : f32, f32)
  ^bb2(%0: f32, %1: f32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.minimum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
}
