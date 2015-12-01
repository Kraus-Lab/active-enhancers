import subprocess
import tempfile
import pytest
from base import check_docker_output


def test_samtools_call():
    out, err = check_docker_output(tool='samtools')
    assert 'samtools' in out
