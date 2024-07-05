#!/usr/bin/env python3
""" Simple program that updates visual studio code from the latest tarball found on Microsofts website """

import argparse
import io
import logging
import os.path
import requests
import shutil
import sys
import tarfile

DL_PATH = "https://update.code.visualstudio.com/latest/linux-x64/stable"
DIR_NAME = "VSCode-linux-x64"

if __name__ == "__main__":
    logging.basicConfig(format="%(levelname)8s; %(asctime)s; %(name)15s: %(message)s", level=logging.INFO)

    parser = argparse.ArgumentParser(description="Update Visual Studio Code from Tarball")
    parser.add_argument("install_dir", help="Path to place vscode folder to")
    parser.add_argument("--code-folder", "-f", required=False, default=DIR_NAME, help="Name of the extracted vscode folder")

    args = parser.parse_args()

    logger = logging.getLogger("vs-code-updater")

    if not os.path.exists(args.install_dir):
        logger.error("Install Directory does not exist!")
        sys.exit(1)
    
    logger.info("----------------------------------------")
    logger.info("Updating Visual Studio Code from tarball")
    logger.info("Source: '{}'".format(DL_PATH))
    logger.info("Destination: '{}'".format(args.install_dir))
    logger.info("----------------------------------------")

    # download file
    logger.info("Downloading tarball...")
    response = requests.get(DL_PATH)
    logger.info("Received update file!")

    # check if vscode_path exists
    vscode_path = os.path.join(args.install_dir, args.code_folder)
    if os.path.exists(vscode_path):
        logger.info("Removing directory '{}'. Are you sure? (y/N) :".format(vscode_path))
        wants_remove = input()
        if wants_remove.strip().lower() == "y":
            # remove dir
            shutil.rmtree(vscode_path)
        else:
            logger.error("Must remove directory in order to update!")
            sys.exit(1)

    logger.info("Uncompressing file...")
    # open the downloaded file as TarBall in memory 
    compressed_file = io.BytesIO(response.content)
    tarball = tarfile.open(fileobj=compressed_file, mode="r:*")
    # extract everything to install dir
    tarball.extractall(args.install_dir, filter="data")
    logger.info("Uncompressed to '{}'!".format(args.install_dir))
    logger.info("Update finished!")
