# wilt

A simpler metric for a cyclomatic complexity checker.

Cyclomatic complexity is a valuable metric in detecting if a codebase
is becoming to hard to comprehend and understand (more nesting levels
usually correlates to an increased cyclomatic complexity).

WILT score (https://github.com/sixty-north/emacs-wilt) stands for:

  Whitespace Integrated over Lines of Text (WILT)

It is a much simpler to calculate method (just look at the source of
'wilt' in this repo for instance), but provides an almost equivalent
value in detecting how much is too much code complexity for a given
code structure.

The performance is very good as well - to check all files in the Emacs
code base and check their WILT scores for instance only took 3 seconds
on an old Lenovo W530 (without any fancy parallelism tricks).

However, if you like performance tricks, consider this:

```sh
time find . -type f -name '*.c' \
  | parallel -j8 ~/src/wilt/wilt -vfile=t {} \
  | sort -nr --parallel=8 \
  | head -n5
5.72665 ./lib/nstrftime.c
4.19062 ./lib/fcntl.c
3.85317 ./src/emacsgtkfixed.c
3.81081 ./lib/acl-internal.c
3.77829 ./lib/set-permissions.c
find . -type f -name '*.c'  0.01s user 0.01s system 97% cpu 0.023 total
parallel -j8 ~/src/wilt/wilt -vfile=t {}  6.85s user 2.53s system 468% cpu 2.003 total
sort -nr --parallel=8  0.01s user 0.00s system 0% cpu 2.003 total
head -n5  0.00s user 0.00s system 0% cpu 2.002 total
```
Just over 2 seconds to check many files and find the 5 that should be
the focus of the most refactor attention.

# Installation

Clone the repo, or just copy the `wilt` file in the repo and plop it
in your `$PATH`.

# Usage

Try out `./wilt` to see the usage guide, similar to this:

```sh
Usage: wilt [OPTION...] FILE

Main usage arguments:

  -vhelp=t          Show this help.
  -vverbose=t       Run in verbose mode.
  -vindent=N        Set indentation level (supersedes ENV setting).
  -vfile=t          Print the file name in the resultant output.

Environment variables:

  INDENT_LEVEL=N    Set the indentation level (superdeded by flag; default=2).

License: AGPLv3 or later.

Report bugs to Matthew Carter <m@ahungry.com>
```

When running it on a file or codebase, you can calculate useful
metrics by combining with other CLI facilities like `find` as such:

```sh
find . -name '*.c' -exec ~/src/wilt/wilt -vfile=t {} \; \
  | sort -n

1 ./c/hof.c
1 ./c/prototypes.c
1 ./c/rawterm/src/util.c
1 ./c/rawterm/src/world.c
1.06667 ./c/list.c
1.08629 ./mercury/Mercury/cs/hello_init.c
1.28289 ./docker-benchmarks/main.c
1.32653 ./c/udp_client.c
1.34667 ./c/map.c
1.43103 ./c/rawterm/src/term.c
1.63158 ./c/rawterm/src/rawterm.c
2 ./c/udp.c
2.18317 ./c/rawterm/src/network.c
2.6672 ./c/editor/main.c
3.625 ./c/sample.c
4.0989 ./c/rawterm/src/view.c
4.39773 ./wm/tinywm.c
```

So, by running it across all C files in my scratch repository
(https://github.com/ahungry/scratch) I can easily see where the
potential problem-points are (tinywm.c has an average indentation
level of 4 blocks, while hof.c never exceeds a single indentation
level anywhere in the codebase).

# Caveats

This makes no assumptions for fancy lexing or analysis - if you have
comment blocks that make use of liberal whitespace in odd ways, this
isn't going to help you there.

Also, you'll want to tune your indent level appropriate to match that
of your codebase.

# Copyright

Matthew Carter <m@ahungry.com>

# License

AGPLv3
