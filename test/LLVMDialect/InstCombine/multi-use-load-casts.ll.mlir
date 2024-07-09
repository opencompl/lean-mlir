module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @t0(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    %2 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink1(%2) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }
  llvm.func @n1(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    %2 = llvm.bitcast %0 : i64 to vector<2xi32>
    llvm.call @sink2(%2) : (vector<2xi32>) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }
  llvm.func @n2(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.call @sink3(%0) : (i64) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }
  llvm.func @abort()
  llvm.func @sink0(!llvm.ptr)
  llvm.func @sink1(!llvm.ptr)
  llvm.func @sink2(vector<2xi32>)
  llvm.func @sink3(i64)
}
