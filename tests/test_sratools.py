import subprocess
import tempfile
import pytest
from base import check_docker_output



def test_fastq_dump_call():
    out, err = check_docker_output(tool='fastq-dump')
    assert 'Program: fastq-dump' in out
