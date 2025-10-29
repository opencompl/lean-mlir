import sys

from xdsl.rewriter import Rewriter
from xdsl.xdsl_opt_main import xDSLOptMain
from xdsl.rewriter import InsertPoint
from xdsl.ir import Block

from xdsl.dialects.builtin import ModuleOp, FunctionType
from xdsl.dialects import llvm
from xdsl.dialects import func


class MyOptMain(xDSLOptMain):
    def process_module(self, module: ModuleOp):
        return_op = module.body.block.ops.last
        assert isinstance(return_op, llvm.ReturnOp)

        new_region = Rewriter().move_region_contents_to_new_regions(module.body)
        func_type = FunctionType.from_lists([], [])
        new_func = func.FuncOp("main", func_type)
        module.body.add_block(Block())
        Rewriter().insert_op(new_func, InsertPoint.at_end(module.body.block))
        new_func.regions = [new_region]

        Rewriter().replace_op(return_op, func.ReturnOp(*return_op.operands))

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
