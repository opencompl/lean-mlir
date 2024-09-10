module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @combine_metadata_dominance1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @use(!llvm.ptr, i32) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>}
  llvm.func @combine_metadata_dominance2(%arg0: !llvm.ptr, %arg1: i1) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @combine_metadata_dominance3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @combine_metadata_dominance4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @combine_metadata_dominance5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @combine_metadata_dominance6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
