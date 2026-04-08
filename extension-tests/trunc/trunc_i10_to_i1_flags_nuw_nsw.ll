
define i1 @main(i10 %0) {
  %2 = trunc nuw nsw i10 %0 to i1
  ret i1 %2
}
