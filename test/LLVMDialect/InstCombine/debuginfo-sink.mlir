#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"a.c" in ".">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang", isOptimized = false, emissionKind = Full>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_basic_type, #di_basic_type>
#di_subroutine_type1 = #llvm.di_subroutine_type<types = #di_basic_type, #di_basic_type, #di_basic_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "foo", file = #di_file, line = 2, scopeLine = 3, subprogramFlags = Definition, type = #di_subroutine_type>
#di_subprogram1 = #llvm.di_subprogram<id = distinct[2]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "bar", file = #di_file, line = 2, scopeLine = 3, subprogramFlags = Definition, type = #di_subroutine_type1>
#di_subprogram2 = #llvm.di_subprogram<id = distinct[3]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "baz", file = #di_file, line = 2, scopeLine = 3, subprogramFlags = Definition, type = #di_subroutine_type>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "h", file = #di_file, line = 4, type = #di_basic_type>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram1, name = "k", file = #di_file, line = 2, type = #di_basic_type>
#di_local_variable2 = #llvm.di_local_variable<scope = #di_subprogram2, name = "l", file = #di_file, line = 2, type = #di_basic_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.intr.dbg.value #di_local_variable = %1 : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @bar(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.intr.dbg.value #di_local_variable1 = %1 : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>
    %3 = llvm.extractelement %2[%0 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %3 : i32
  }
  llvm.func @baz(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.intr.dbg.value #di_local_variable2 #llvm.di_expression<[DW_OP_plus_uconst(5)]> = %1 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable2 = %1 : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}
