#!/usr/bin/python3
"""
Fabric script to generate a .tgz archive from the
contents of the web_static folder
"""

from fabric.api import local
from datetime import datetime
import os


def do_pack():
    """Function to compress directory"""
    if not os.path.exists("versions"):
        os.makedirs("versions")
    date = datetime.now().strftime("%Y%m%d%H%M%S")
    archive_path = "versions/web_static_{}.tgz".format(date)
    local("tar -cvzf {} web_static".format(archive_path))
    if os.path.exists(archive_path):
        return archive_path
    return None
