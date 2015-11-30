import subprocess
import tempfile
import pytest


def test_cutadapt_call(check_docker_output):
    out, err = check_docker_output(tool='active-enhancers/cutadapt')
    self.assertTrue('cutadapt version 1.2.1' in out)
