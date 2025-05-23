#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "jinja2",
# ]
# ///
"""
Link stuff into home directory
"""
import hashlib
import os
import pathlib
import platform
import shutil
import subprocess
import sys
import tomllib
from itertools import chain
from jinja2 import Environment, FileSystemLoader


ENABLE_COLOR = False if "--no-color" in sys.argv[1:] else True
VERBOSE = "-v" in sys.argv[1:]

class C:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def cprint(clr, fmt, *args):
    if ENABLE_COLOR and clr is not None:
        print(clr + fmt.format(*args) + C.ENDC)
    else:
        print(fmt.format(*args))


def distro():
    "semi-portable distribution id"
    if os.path.exists('/etc/os-release'):
        cmd = r"cat /etc/os-release | egrep \^ID="
        osname = subprocess.check_output(cmd, shell=True).decode('utf-8')
        osname = osname[3:].strip().lower()
        if 'suse' in osname:
            osname = 'suse'
    else:
        osname = 'mac'
    return osname


UNAME = platform.uname()
OSNAME = distro()
HOSTNAME = UNAME.node.lower().split('.')[0]
CUSTOM = {}


for local_file in ("~/.dotfiles.ini", "~/.config/dotfiles.ini"):
    fn = os.path.expanduser(local_file)
    if os.path.isfile(fn):
        import configparser
        config = configparser.ConfigParser()
        config.read(fn)
        print(f"read {fn} to {config.sections()}")
        for key, value in config["local"].items():
            if key == "tags":
                CUSTOM[key] = value.split()
            else:
                CUSTOM[key] = value
        break

if not CUSTOM.get("name") or not CUSTOM.get("email") or not CUSTOM.get("tags"):
    print("Please create ~/.config/dotfiles.ini")
    print("Make sure at least name, email and tags are set!")
    sys.exit(1)




def altname(nam):
    "find custom alternate versions of files"
    path, basename = os.path.split(nam)
    name, ext = os.path.splitext(basename)

    altpaths = [nam]
    tags = CUSTOM["tags"]
    for key in chain((HOSTNAME,
                UNAME.system.lower(),
                UNAME.machine.lower(),
                OSNAME), tags):
        altpaths.append(os.path.join(path, "{}-{}{}".format(name, key.lower(), ext)))

    for machine in (HOSTNAME,
                UNAME.system.lower(),
                UNAME.machine.lower(),
                          OSNAME):
        for tag in tags:
            altpaths.append(os.path.join(path, "{}-{}-{}{}".format(name, machine.lower(), tag, ext)))


    for path in altpaths:
        if os.path.exists(path):
            return path
        if os.path.exists(f"{path}.jinja"):
            return f"{path}.jinja"

    print("could not find", nam)
    print("altnames", ", ".join(altpaths))
    sys.exit(1)

def hash_of(filename):
    fbytes = pathlib.Path(filename).read_bytes()
    return hashlib.sha1(fbytes).hexdigest()

def jinjafy(frm):
    "render template target actual file"
    params = {
        "hostname": UNAME.node.lower(),
        "system": UNAME.system.lower(),
        "arch": UNAME.machine.lower(),
    }
    params.update(CUSTOM)

    renderdir = os.path.expanduser("~/.config/dotfiles/rendered")
    os.makedirs(renderdir, exist_ok=True)

    _, basename = os.path.split(frm)
    name, _ = os.path.splitext(basename)

    rendered = os.path.join(renderdir, name)

    # if os.path.isfile(rendered) and is_newer(rendered, frm):
    #     cprint(C.OKBLUE, "@ {} -> {} (already rendered)".format(frm, rendered))
    #     return rendered

    tmp_rendered = f"{rendered}.tmp"

    cprint(C.OKBLUE, "@ {} -> {}".format(frm, tmp_rendered))
    try:
        with open(frm) as ifo, open(tmp_rendered, 'w') as ofo:
            template = Environment(loader=FileSystemLoader('.')).from_string(ifo.read())
            ofo.write(template.render(**params))

        if not os.path.isfile(rendered):
            cprint(C.OKGREEN, "@ {} ~> {}".format(tmp_rendered, rendered))
            os.rename(tmp_rendered, rendered)
        elif hash_of(tmp_rendered) != hash_of(rendered):
            cprint(C.OKGREEN, "@ {} -> {}".format(tmp_rendered, rendered))
            shutil.copyfile(tmp_rendered, rendered)
        else:
            cprint(C.OKBLUE, "@ {} -> {} (already rendered)".format(frm, rendered))
    finally:
        if os.path.isfile(tmp_rendered):
            os.remove(tmp_rendered)

    return rendered


def in_home(path):
    "return path in home dir"
    return os.path.join(os.path.expanduser("~"), path)


def is_mac():
    "true if on a mac"
    return distro() == 'mac'


def makedirs_p(path):
    """
    os.makedirs, but ignore failure
    """
    try:
        os.makedirs(path)
    except OSError:
        pass


def is_x(path):
    """
    True if file at path is executable
    """
    return os.path.isfile(path) and os.access(path, os.X_OK)


def backup(frm, target):
    "make a backup of the file"
    import filecmp
    if not target.endswith(frm):
        target = os.path.join(target, frm)
    n = 1
    ntarget = target
    while os.path.exists(ntarget):
        if filecmp.cmp(frm, ntarget):
            if os.path.isdir(frm):
                shutil.rmtree(frm)
            else:
                os.unlink(frm)
            return
        ntarget = "{}-{}".format(target, n)
        n += 1
        if n > 10:
            break
    cprint(C.WARNING, "^ {} ~> {}".format(frm, ntarget))
    shutil.move(frm, ntarget)


def is_newer(first, second):
    "true if a is newer than b"
    return os.path.getmtime(first) > os.path.getmtime(second)


DOTS_DIR = in_home("src/dotfiles")
OLD_DIR = os.path.join(DOTS_DIR, "_old")
makedirs_p(OLD_DIR)


def link(frm, target):
    "links file in dots dir target file in home dir"
    frm = altname(frm)
    if VERBOSE:
        cprint(None, "? {} {}", frm, target)

    if frm.endswith(".jinja"):
        tmpl = frm
        frm = frm[:-6]
    else:
        tmpl = f"{frm}.jinja"
    dotsfrom = os.path.join(DOTS_DIR, frm)
    print(f"tmpl={tmpl}, frm={frm}")

    if os.path.exists(tmpl):
        dotsfrom = jinjafy(tmpl)

    tgt = in_home(target)
    if os.path.islink(tgt):
        oldtgt = os.readlink(tgt)
        if dotsfrom != oldtgt:
            cprint(C.FAIL, "- {} -> {}", tgt, oldtgt)
            os.unlink(tgt)
        else:
            return
    elif os.path.exists(tgt):
        backup(tgt, OLD_DIR)

    cprint(C.OKGREEN, "* {} -> {}", tgt, dotsfrom)
    makedirs_p(os.path.dirname(tgt))
    os.symlink(dotsfrom, tgt)


def copy_bin():
    "link all the binaries target ~/bin"
    bindir = in_home("bin")
    makedirs_p(bindir)
    srcdir = os.path.join(DOTS_DIR, "bin")
    bins = [(f, os.path.join(srcdir, f)) for f in os.listdir(srcdir)
            if is_x(os.path.join(srcdir, f))]
    for name, path in bins:
        link(path, os.path.join(bindir, name))

def main():
    copy_bin()

    with open("links.toml", "rb") as f:
        links = tomllib.load(f)
        for name, target in links.items():
            if isinstance(target, dict):
                if name in CUSTOM["tags"]:
                    for sname, starget in target.items():
                        link(sname, starget)
            else:
                link(name, target)

if __name__ == "__main__":
    main()
