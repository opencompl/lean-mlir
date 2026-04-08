
define i10 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i10
  ret i10 %2
}
