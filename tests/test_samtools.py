import subprocess
import tempfile
import pytest

def test_samtools_call(check_docker_output):
    out, err = check_docker_output(tool='active-enhancers/samtools')
    self.assertTrue('samtools' in out)
