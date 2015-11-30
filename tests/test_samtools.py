import subprocess
import tempfile
import pytest
from base import check_docker_output


def test_samtools_call(self):
    out, err = check_docker_output(tool='active-enhancers/samtools')
    self.assertTrue('samtools' in out)
