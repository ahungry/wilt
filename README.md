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

# Copyright

Matthew Carter <m@ahungry.com>

# License

AGPLv3
