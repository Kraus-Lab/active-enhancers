import subprocess
import pytest


def check_docker_output(tool):
    command = 'docker run active-enhancers ' + tool
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    output = process.communicate()
    return output
