
define i20 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i20
  ret i20 %2
}
