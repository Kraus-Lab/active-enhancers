import subprocess
import pytest

@pytest.fixture(params=tool)
def check_docker_output(request):
    command = 'docker run ' + request.tool
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    output = process.communicate()
    return out
