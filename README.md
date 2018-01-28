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
logbook stats <file>...
```

### stats

The `stats` command reads from one or more files and prints out the amount of
time logged in each file:

```console
$ logbook stats *.logbook
2018-01-18.logbook: 1h47min
2018-01-19.logbook: 2h28min
2018-01-20.logbook: 2h54min
2018-01-21.logbook: 2h48min
2018-01-22.logbook: 1h24min
```

## Changelog

### 0.1

  * Add `stats` command showing the number of hours logged in a given file

## License

`logbook-cli` is licensed under the Apache License 2.0.
See [`LICENSE`](LICENSE) for more information.
