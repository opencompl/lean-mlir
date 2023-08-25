namespace LLVM

declare_syntax_cat ty
declare_syntax_cat local_ident
declare_syntax_cat global_ident
declare_syntax_cat expr
declare_syntax_cat bb
declare_syntax_cat defn
declare_syntax_cat ast

syntax "i" noWs num : ty
syntax ty "x" ty : ty
syntax "%" ident : local_ident
syntax "%" num : local_ident
syntax "@" ident : global_ident
syntax "@" num : global_ident

syntax "ret" (ty)? expr : bb
--syntax "br" bb : bb
syntax local_ident "=" ident (ty)? local_ident,* : bb
