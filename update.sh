
(cd SSA/Projects/InstCombine/; sed -e 's/EDSL/EDSLPretty/' -i Alive*.lean)
(cd SSA/Projects/InstCombine/; sed -e 's/= "\(llvm..*\)" (\(.*\),\(.*\)) : (\(.*\),.*) -> (.*)/= \1 \2, \3 : \4/' -i Alive*.lean)
(cd SSA/Projects/InstCombine/; sed -e 's/= "\(llvm..*\)" (\(.*\)) : (\(.*\)) -> (.*)/= \1 \2 : \3/' -i Alive*.lean)
(cd SSA/Projects/InstCombine/; sed -e 's/"\(llvm.return\)" (\(.*\)) : (\(.*\)) -> (.*)/\1 \2 : \3/' -i Alive*.lean)
(cd SSA/Projects/InstCombine/; sed -e 's/= "\(llvm.mlir.constant\)" () { value = \(.*\) : \(.*\) } :() -> (\(.*\))/= \1 \2 : \3/' -i Alive*.lean)
