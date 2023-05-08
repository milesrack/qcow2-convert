# qcow2-convert
Bash script to convert VM disk images to the qcow2 format.

## Installation
```
git clone https://github.com/milesrack/qcow2-convert
cd qcow2-convert
```

## Usage
```
Usage: ./convert.sh <disk_image>
```
The script will output the path of the new qcow2 disk image.

## Examples
To convert a remote file:
```
./convert.sh https://download.vulnhub.com/noob/Noob.ova
```

To convert a local file:
```
./convert.sh Noob.ova
```
