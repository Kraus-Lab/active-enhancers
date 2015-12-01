import subprocess
import tempfile
import pytest
from base import check_docker_output


def test_cutadapt_call():
    out, err = check_docker_output(tool='cutadapt')
    assert 'cutadapt' in out
