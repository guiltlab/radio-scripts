#!/usr/bin/env python3

import os
import sys
import logging
import argparse
from hashlib import md5
import subprocess as sp
from multiprocessing import pool
from mutagen import flac as mut_flac

# edit this: (on linux, 'flac' [with quotes] is most likely the value to use)
FLAC_PROG = "C:\\Program Files (x86)\\foobar2000\\encoders\\flac.exe"

# --------------------

logger = logging.getLogger(__name__)
CHUNK_SIZE = 512 * 1024


def scantree(path: str, recursive=False):
    for entry in os.scandir(path):
        if entry.is_dir():
            if recursive:
                yield from scantree(entry.path, recursive)
        else:
            yield entry


def get_flac(path: str):
    try:
        return mut_flac.FLAC(path)
    except mut_flac.FLACNoHeaderError:  # file is not flac
        return
    except mut_flac.error as e:  # file < 4 bytes
        if str(e).startswith('file said 4 bytes'):
            return
        else:
            raise e


def get_flacs_no_md5(path: str, recursive=False):
    for entry in scantree(path, recursive):
        flac_thing = get_flac(entry.path)
        if flac_thing is not None and flac_thing.info.md5_signature == 0:
            yield flac_thing


def get_md5(flac_path: str) -> bytes:
    md_5 = md5()
    with sp.Popen(
            [FLAC_PROG, '-ds', '--stdout', '--force-raw-format', '--endian=little', '--sign=signed', flac_path],
            stdout=sp.PIPE,
            stderr=sp.DEVNULL) as decoding:

        for chunk in iter(lambda: decoding.stdout.read(CHUNK_SIZE), b''):
            md_5.update(chunk)

    return md_5.digest()


def set_md5(flac_thing: mut_flac.FLAC):
    flac_thing.info.md5_signature = int.from_bytes(get_md5(flac_thing.filename), 'big')
    flac_thing.tags.vendor = 'MD5 added'
    flac_thing.save()
    return flac_thing


def main(path: str, recursive=False, check_only=False):
    found = False
    if check_only:
        for flac_thing in get_flacs_no_md5(path, recursive=recursive):
            logger.info(flac_thing.filename)
            found = True
    else:
        with pool.ThreadPool() as tpool:
            for flac_thing in tpool.imap(set_md5, get_flacs_no_md5(path, recursive=recursive)):
                logger.info(f'MD5 added: {flac_thing.filename}')
                found = True
    if not found:
        logger.info('No flacs without MD5 found')


def parse_args():
    parser = argparse.ArgumentParser(prog='Add MD5')
    parser.add_argument('dirpath')
    parser.add_argument('-r', '--recursive', help='Include subdirs', action='store_true')
    parser.add_argument('-c', '--check_only', help='don\'t add MD5s, just print the flacs that don\'t have them.',
                        action='store_true')
    args = parser.parse_args()

    return args.dirpath, args.recursive, args.check_only


if __name__ == '__main__':
    logger.setLevel(10)
    logger.addHandler(logging.StreamHandler(stream=sys.stdout))
    main(*parse_args())