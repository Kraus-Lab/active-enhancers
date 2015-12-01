import subprocess
import tempfile
import pytest
from base import check_docker_output



def test_bwa_call():
    out, err = check_docker_output(tool='bwa')
    assert 'Program: bwa' in out
