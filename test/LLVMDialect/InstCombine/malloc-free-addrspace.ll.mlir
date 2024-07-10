module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<200>, dense<[128, 128, 128, 64]> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.alloca_memory_space", 200 : ui64>, #dlti.dl_entry<"dlti.program_memory_space", 200 : ui64>, #dlti.dl_entry<"dlti.global_memory_space", 200 : ui64>>} {
  llvm.func @remove_malloc() -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr<200>
    llvm.call @free(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }
  llvm.func @remove_calloc() -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr<200>
    llvm.call @free(%3) : (!llvm.ptr<200>) -> ()
    llvm.return %2 : i64
  }
  llvm.func @remove_aligned_alloc() -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @aligned_alloc(%0, %0) : (i64, i64) -> !llvm.ptr<200>
    llvm.call @free(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }
  llvm.func @remove_strdup(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @strdup(%arg0) : (!llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.call @free(%1) : (!llvm.ptr<200>) -> ()
    llvm.return %0 : i64
  }
  llvm.func @remove_new(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr<200>
    llvm.call @_ZdlPv(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }
  llvm.func @remove_new_array(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr<200>
    llvm.call @_ZdaPv(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }
  llvm.func @calloc(i64, i64) -> (!llvm.ptr<200> {llvm.noalias}) attributes {passthrough = ["nounwind", ["allockind", "17"], ["allocsize", "1"], ["alloc-family", "malloc"]]}
  llvm.func @malloc(i64) -> (!llvm.ptr<200> {llvm.noalias}) attributes {passthrough = [["allockind", "9"], ["allocsize", "4294967295"], ["alloc-family", "malloc"]]}
  llvm.func @aligned_alloc(i64, i64) -> (!llvm.ptr<200> {llvm.noalias}) attributes {passthrough = [["allockind", "41"], ["allocsize", "8589934591"], ["alloc-family", "malloc"]]}
  llvm.func @strdup(!llvm.ptr<200>) -> (!llvm.ptr<200> {llvm.noalias})
  llvm.func @free(!llvm.ptr<200>) attributes {passthrough = [["allockind", "4"], ["alloc-family", "malloc"]]}
  llvm.func @_Znwm(i64) -> (!llvm.ptr<200> {llvm.noalias})
  llvm.func @_ZdlPv(!llvm.ptr<200>)
  llvm.func @_Znam(i64) -> (!llvm.ptr<200> {llvm.noalias})
  llvm.func @_ZdaPv(!llvm.ptr<200>)
}
