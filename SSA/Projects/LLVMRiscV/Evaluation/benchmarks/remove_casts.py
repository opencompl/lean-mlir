import sys

from xdsl.rewriter import Rewriter
from xdsl.xdsl_opt_main import xDSLOptMain
from xdsl.rewriter import InsertPoint
from xdsl.ir import Block

from xdsl.dialects.builtin import ModuleOp, NoneAttr, StringAttr, FunctionType
from xdsl.dialects import llvm
from xdsl.dialects.riscv import IntRegisterType
from xdsl.dialects import riscv_func
from xdsl.transforms.reconcile_unrealized_casts import ReconcileUnrealizedCastsPass


class MyOptMain(xDSLOptMain):
    def process_module(self, module: ModuleOp):
        reg_type = IntRegisterType(NoneAttr(), StringAttr(""))
        module_args = module.body.block.args
        return_op = module.body.block.ops.last
        assert isinstance(return_op, llvm.ReturnOp)

        new_region = Rewriter().move_region_contents_to_new_regions(module.body)
        new_func = riscv_func.FuncOp(
            "main",
            new_region,
            FunctionType.from_lists(
                [reg_type] * len(module_args), [reg_type] * len(return_op.operands)
            ),
        )

        module.body.add_block(Block())

        Rewriter().insert_op(new_func, InsertPoint.at_end(module.body.block))
        for arg in module_args:
            Rewriter().replace_value_with_new_type(
                arg, IntRegisterType(NoneAttr(), StringAttr(""))
            )

        for arg in return_op.operands:
            Rewriter().replace_value_with_new_type(
                arg, IntRegisterType(NoneAttr(), StringAttr(""))
            )

        Rewriter().replace_op(return_op, riscv_func.ReturnOp(*return_op.operands))
        ReconcileUnrealizedCastsPass().apply(self.ctx, module)

    def run(self):
        chunks, file_extension = self.prepare_input()
        output_stream = self.prepare_output()

        try:
            for i, (chunk, offset) in enumerate(chunks):
                try:
                    if i > 0:
                        output_stream.write("// -----\n")
                    module = self.parse_chunk(chunk, file_extension, offset)

                    if module is not None:
                        self.process_module(module)
                        output_stream.write(self.output_resulting_program(module))
                    output_stream.flush()
                finally:
                    chunk.close()
        finally:
            if output_stream is not sys.stdout:
                output_stream.close()

        exit(0)


def main():
    MyOptMain().run()


if "__main__" == __name__:
    main()