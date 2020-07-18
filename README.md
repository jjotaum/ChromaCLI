# Chroma

A command line tool to generate swift colors definitions from .xcassets files.

### Usage

```
$ Chroma --help

USAGE: generator [--name <name>] [--output <output>] [--platform <platform>]

OPTIONS:
  -n, --name <name>       Defines the name of the generated file. (default:
                          Chroma)
  -o, --output <output>   Specifies generated file type.
                          Supported values: "extension","struct". (default:
                          extension)
  -p, --platform <platform>
                          Specifies the platform compatibility of the exported
                          file. (default: iOS)
  -h, --help              Show help information.
```

### Installation

Clone Chroma on your machine:

```
$ git clone https://github.com/jjotaum/Chroma.git
```
Navigate to it's directory:

```
$ cd Chroma
```

Execute install script
```
$ ./install.sh
```
Chroma should now be installed on /usr/local/bin and can be accessed via terminal.
```
$ chroma
```