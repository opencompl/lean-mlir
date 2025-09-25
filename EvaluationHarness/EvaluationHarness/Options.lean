import Lean

/-!
# Evaluation Harness Options
This file defines various options which can be used to influence the behaviour
of `#evaluation in cmd`.
-/
namespace EvaluationHarness
open Lean

initialize
  registerOption `evaluation.includeWallTime {
    defValue := false
    descr := "Whether to include elapsed wall-time in the output of `#evaluation in cmd`"
  }
  registerOption `evaluation.includeMessages {
    defValue := true
    descr := "Whether to include a log of all messages in the output of `#evaluation in cmd`.\
      When set to false, messages are still captured, but then they are discarded \
      instead of incorporated into the output."
  }

  registerOption `evaluation.outputAsLog {
    defValue := false
    descr := "When set, output is emitted via `logInfo`, rather than `IO.println`"
  }
  registerOption `evaluation.includePosition {
    defValue := true
    descr := "Whether to include line/column information in the output. \
      When set to false, all lines and columns are reported as 0. \
      \n\n\
      Can be particularly useful to disable in tests, to make the output less
      brittle to changes in the overal file."
  }
