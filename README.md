# logbook-cli

`logbook-cli` is a Ruby gem providing the `logbook` executable which offers
various commands to process logbook files.

## On Logbooks

Logbooks are plain text files used to capture thoughts and activities as they
occur throughout the day without interrupting flow as much as possible.

The rather minimalistic syntax is optimized for readability and quick editing
without the need for anything fancier than a good text editor.

To find out more about logbooks and the logbook file format, check out the
documentation of [the vim plugin](https://github.com/logbooksh/vim-logbook).

## Installation

`logbook-cli` is packaged as a Ruby gem and requires Ruby 2.4+.

```console
$ gem install logbook-cli
```

## Usage

Once installed, you have access to the `logbook` executable:

```console
$ logbook
logbook stats [--per-task] <file>...
```

### stats

The `stats` command reads from one or more files and prints out the amount of
time logged in each file:

```console
$ logbook stats *.logbook
2018-03-04.logbook: 4 h 11 min
2018-03-08.logbook: 55 min
2018-03-09.logbook: 42 min
2018-03-10.logbook: 1 h 14 min
```

The `--per-task` option can be used to break down the amount of time logged per
task in each file:

```console
$ logbook stats --per-task *.logbook
2018-03-04.logbook: 4 h 11 min
                    Add user registration: 4 h 11 min
2018-03-08.logbook: 55 min
                    Add --per-task option: 32 min
                    Parse logbook files that do not end with an empty line: 23 min
2018-03-09.logbook: 42 min
                    Add --per-task option: 42 min
2018-03-10.logbook: 1 h 14 min
                    Add --per-task option: 1 h 14 min
```

## Changelog

### 0.1.1

  * Add `--per-task` option

### 0.1

  * Add `stats` command showing the number of hours logged in a given file

## License

`logbook-cli` is licensed under the Apache License 2.0.
See [`LICENSE`](LICENSE) for more information.
