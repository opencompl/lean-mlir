from typing import Callable, TypeVar, List, Optional, Any
from concurrent.futures import ThreadPoolExecutor
from tqdm import tqdm # Fancy Progress Bar
from argparse import ArgumentParser

#
# Task Queue implementation
#

T = TypeVar('T')

class TaskQueue:
    def __init__(self, max_threads: int, stride: int = 1, offset: int = 0, show_progress_bar: bool = True):
        # Maximum number of threads to use on the current machine
        self.max_threads = max_threads
        # Number of tasks to skip between each processed task
        self.stride = stride
        # Starting index for processing tasks
        self.offset = offset
        # Whether to show a progress bar on stdout
        self.show_progress_bar = show_progress_bar

    def run_tasks(
        self,
        tasks: List[T],
        *,
        run: Callable[[T], Optional[str]],
        output_file: Optional[str] = None,
    ):
        """
        `run_tasks` is a light-weight, static distributed task-queue.

        Given a list `tasks` of task descriptions of a generic type `T`, and a function
        `run` which takes a task description as input and executes the task, `run_tasks`
        will run all tasks, in a parallelized way.

        It is static, meaning that the list of all tasks to be run needs to be known
        entirely up-front, which allows us to distribute the tasks over many machines
        in a straightforward way, without requiring complex coordination.

        The `config` controls the parallelism, where `config.max_threads` controls
        the degree of multi-threading for a single invocation of the script, and
        `self.stride` and `self.offset` enable distribution over multiple invocations
        (and hence, over multiple machines), where
        * `self.stride` should be set to the total number of parallel jobs being run, and
        * Each parallel job should get a different value of `self.offset`, ranging from
            0 to `self.stride-1` (inclusive), to guarantee each task is run exactly once.

        Note that, since tasks may be distributed over multiple invocations of a script,
        the `run` function should *not* rely on mutating global state to aggregate results.
        Instead, `run` is expected to return a single line (without terminating new-line)
        in some format which is safe to concatenate (preferably jsonl), the output of each task 
        (run by the current job) is concatenated and collected in a single file at the path
        specified by `output_file`. Note that this file is truncated if it already
        exists. If `output_file` is None, output is printed to stdout instead.

        If `run` returns `None` for a task, no output is produced (in particular, 
        we do *not* write an empty line in such a case).
        """

        tasks = tasks[self.offset::self.stride]

        with ThreadPoolExecutor(max_workers=self.max_threads) as executor:
            futures = [executor.submit(run, task) for task in tasks]
            if self.show_progress_bar:
                futures = tqdm(futures)

            if output_file is None:
                for future in futures:
                    result = future.result()
                    if result is not None:
                        print(result)
            else:
                with open(output_file, "w") as f_out:
                    for future in futures:
                        result = future.result()
                        if result is not None:
                            f_out.write(str(result) + '\n')
            
        return

#
# CLI argument parsing
#

def add_cli_arguments(parser: ArgumentParser):
    """
    Register the CLI flags that control the task queue behaviour
    with an ArgumentParser
    """
    group = parser.add_argument_group("Task Queue")
    group.add_argument(
        "--stride",
        type=int,
        default=1,
        help="For distributed runs, the total number of jobs."
    )

    group.add_argument(
        "--offset",
        type=int,
        default=0,
        help="For distributed runs, the index of the current runner. " \
        "Each runner should be assigned a different offset in the range from `0` to `n-1` (inclusive), " \
        "where `n` is the total number of runners (i.e., the stride)."
    )

    group.add_argument(
        "--max-threads",
        type=int,
        default=1,
        help="The maximum number of threads to use. When set to 0, runs as many threads as CPU cores available."
    )

    group.add_argument(
        "--show-progress",
        type=bool,
        default=True,
        help="Whether to show a progress bar to track how many tasks have been completed already."
    )

def from_parsed_cli_arguments(args: Any) -> TaskQueue:
    """
    Construct a `TaskQueue` from parsed CLI arguments.
    The `args` are expected to have come from an `ArgumentParser.parse_args`
    call where the parser has had `add_cli_arguments` from the current module
    called on it, to ensure the relevant CLI arguments are available!
    """
    return TaskQueue(args.max_threads, args.stride, args.offset, args.show_progress)