import subprocess
import tempfile
import pytest
from base import check_docker_output



def test_bwa_call(self):
    out, err = check_docker_output(tool='active-enhancers/bwa')
    self.assertTrue('Program: bwa' in out)
