#! /usr/bin/env python3

import filecmp
import os
import os.path
import re
import sys

debug = False
outputFile = None
somente1 = []
somente2 = []
diferentes = []
erros = []

filtro_extra = []

def log(msg):
    outputFile.write(f"{msg}\n")
    print(msg)


def filtro(inputFile):
    if inputFile[-4:].lower() in [".dcu", ".ddp"]:
        if debug:
            print(f"Ignorado: {inputFile} (Delphi temp file)")
        return None

    if inputFile[-5:][:2] == ".~":
        if debug:
            print(f"Ignorado: {inputFile} (backup file)")
        return None

    for r in filtro_extra:
        if r.match(inputFile):
            if debug:
                print(f"Ignorado: {inputFile}")
            return None

    return inputFile


def logCmp(a, b, ignore, newFmt, comp):
    for filename in comp.left_only:
        if filtro(os.path.join(a, filename)):
            somente1.append((a, filename))

    for filename in comp.right_only:
        if filtro(os.path.join(b, filename)):
            somente2.append((b, filename))

    for filename in comp.diff_files:
        if filtro(os.path.join(a, filename)):
            if filtro(os.path.join(b, filename)):
                diff_files.append((a, b, filename))

    for sub, obj in comp.subdirs.items():
        p1 = os.path.join(a, sub)
        p2 = os.path.join(b, sub)
        logCmp(p1, p2, ignore, newFmt, obj)


def doComp(a, b, newFmt, ignore):
    comp = filecmp.dircmp(a, b, ignore)
    logCmp(a, b, ignore, newFmt, comp)

    somente1.sort()
    somente2.sort()
    diferentes.sort()


    if os.name == "posix":
        command = "diff"
    else:
        command = "gvimdiff"

    if somente1:
        log(f"\nArquivos que existem apenas em {a}:\n")
        for (a, filename) in somente1:
            log(f"{os.path.join(a, filename)}\n")

    if somente2:
        log(f"\nArquivos que existem apenas em {b}:\n")
        for (b, filename) in somente2:
            log(f"{os.path.join(b, filename)}\n")

    if diferentes:
        log("\nArquivos diferentes:\n")

        for (a, b, filename) in diferentes:
            log(f"{command} {os.path.join(a, filename)}\t{os.path.join(b, filename)}")


if __name__ == "__main__":
    ignore = ["svn", ".svn", "CVS", "tags", ".cvsignore", ".vs"]

    p1 = sys.argv[1]
    p2 = sys.argv[2]

    if len(sys.argv) > 3:
        if len(sys.argv) > 4:
            for s in sys.argv[4:]:
                print(f"Ignorar: [{s}]")
                filtro_extra.append(re.compile(s))

        outputFile = open(sys.argv[3], "w+")

    log(f"\n\nComparando '{p1}' e '{p2}'\n\n")

    doComp(p1, p2, True, ignore)

