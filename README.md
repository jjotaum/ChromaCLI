# Chroma

A command line tool to auto generate .swift extensions or structs files from .xcassets on your iOS, macOS & SwiftUI projects.

### Usage

```
$ Chroma --help

USAGE: chroma --asset <asset> --path <path> [--type <type>] [--platform <platform>]

OPTIONS:
  -a, --asset <asset>     The path of .xcasset file. 
  -p, --path <path>       The path of the generated .swift file. 
  -t, --type <type>       Specifies generated file type.
                          Supported values: "extension","struct". (default:
                          extension)
  --platform <platform>   Specifies the platform compatibility of the exported
                          file.
                          iOS, macOS, swiftUI (default: iOS)
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

### Integrate Chroma on your Xcode Project

You can easily integrate Chroma on your Xcode project to maintain your generated files updated.

Select your project target on Xcode > go to `Build Phases` tab > Press on `+` > Select `New Run Script Phase` > Uncheck `Based on dependency analysis` option.

Copy & paste below command on your new script phase and update paths & platform parameters according to your needs.

```
chroma --asset MyProject/Assets.xcassets --path MyProject/Extensions/Colors.swift --platform swiftUI
```
Optionally you can rename your new `Run Script` to `Chroma`.
