
define i4 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i4
  ret i4 %2
}
