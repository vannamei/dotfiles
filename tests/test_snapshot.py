import importlib.util
from pathlib import Path
import subprocess
import tempfile
import unittest

module_path = Path(__file__).resolve().parents[1] / 'scripts/snapshot.py'
spec = importlib.util.spec_from_file_location('snapshot', module_path)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

class SnapshotTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        base = Path(self.tmp.name)
        self.repo, self.home = base/'repo', base/'home'
        self.repo.mkdir()
        self.home.mkdir()
        self.git('init', '-q')
        self.git('config', 'user.name', 'Test')
        self.git('config', 'user.email', 'test@example.invalid')
        for root in (self.repo, self.home):
            for rel, value in zip(module.FILES, ('{"profiles": []}\n', '[tools]\nnode = "22.16.0"\n')):
                p = root/rel
                p.parent.mkdir(parents=True, exist_ok=True)
                p.write_text(value)
        self.git('add', '.')
        self.git('commit', '-qm', 'baseline')

    def tearDown(self):
        self.tmp.cleanup()

    def git(self, *args):
        return subprocess.run(['git', '-C', str(self.repo), *args], check=True, capture_output=True)

    def test_check_then_import_with_backup(self):
        rel = module.FILES[0]
        previous = (self.repo/rel).read_text()
        (self.home/rel).write_text('{"profiles": [{"name":"new"}]}\n')
        self.assertEqual(module.snapshot(self.repo, self.home, check=True), 1)
        self.assertEqual((self.repo/rel).read_text(), previous)
        self.assertEqual(module.snapshot(self.repo, self.home), 0)
        self.assertEqual((self.repo/rel).read_bytes(), (self.home/rel).read_bytes())
        backups = list((self.repo/'.git/dotfiles-snapshots').glob('*/'+rel))
        self.assertEqual(len(backups), 1)
        self.assertEqual(backups[0].read_text(), previous)
        self.assertEqual(module.snapshot(self.repo, self.home, check=True), 0)

    def test_conflicting_repo_edit_is_not_overwritten(self):
        rel = module.FILES[0]
        (self.repo/rel).write_text('{"repo":true}')
        (self.home/rel).write_text('{"live":true}')
        with self.assertRaises(RuntimeError):
            module.snapshot(self.repo, self.home)
        self.assertEqual((self.repo/rel).read_text(), '{"repo":true}')

    def test_invalid_toml_prevents_all_writes(self):
        rel = module.FILES[0]
        before = (self.repo/rel).read_text()
        (self.home/rel).write_text('{"live":true}')
        (self.home/module.FILES[1]).write_text('[broken')
        with self.assertRaises(ValueError):
            module.snapshot(self.repo, self.home)
        self.assertEqual((self.repo/rel).read_text(), before)

if __name__ == '__main__':
    unittest.main()
