import subprocess
import tempfile
import pytest


def test_bwa_call():
    out, err = check_docker_output(tool='active-enhancers/bwa')
    self.assertTrue('Program: bwa' in out)
